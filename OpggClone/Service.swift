//
//  Service.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/01/10.
//

import Foundation
import Combine
import Alamofire


class Service {
    
    @Published var regionPicker: UrlHeadPoint = .kr
    @Published var searchBarText: String = ""
    
    @Published var summonerInfo: SummonerInfo?
    @Published var leagueInfo: [SummonersLeagueElement] = []
    @Published var matchList: [String] = []
    @Published var matchInfos: [MatchInfo] = []
    
//    @Published var isLoading: Bool = false
    
    var subscription = Set<AnyCancellable>()
    
    func requestSummonerInfo(urlBaseHead: UrlHeadPoint, name: String) async throws -> SummonerInfo {
        
        let value =
        try await ApiClient.shared.session
            .request(Router.summoner(urlBaseHead: urlBaseHead, name: name))
            .serializingDecodable(SummonerInfo.self)
            .value
        return value
        
    }
    
    func requestLeaguesInfo(urlBaseHead: UrlHeadPoint, encryptedSummonerId: String) async throws -> [SummonersLeagueElement] {
        let value =
        try await ApiClient.shared.session
            .request(Router.league(urlBaseHead: urlBaseHead, encryptedSummonerId: encryptedSummonerId))
            .serializingDecodable([SummonersLeagueElement].self)
            .value
        return value
    }
    
    func requestMatchList(urlBaseHead: UrlHeadPoint, puuid: String) async throws -> [String]  {
        let value =
        try await ApiClient.shared.session
            .request(Router.match(urlBaseHead: urlBaseHead, puuid: puuid))
            .serializingDecodable([String].self)
            .value
        return value
    }
    
    private func requestMatchInfo(urlBaseHead: UrlHeadPoint, matchId: String) async throws -> MatchInfo  {
        let value =
        try await ApiClient.shared.session
            .request(Router.matchInfo(urlBaseHead: urlBaseHead, matchId: matchId))
            .serializingDecodable(MatchInfo.self)
            .value
        return value
    }
    
    func requestMatchInfos(urlBaseHead: UrlHeadPoint, matchIds: [String]) async throws -> [MatchInfo] {

        var matchInfosValue: [MatchInfo] = []
        for matchId in matchIds {
         async let aValue = try await requestMatchInfo(urlBaseHead: urlBaseHead, matchId: matchId)
           try await matchInfosValue.append(aValue)
        }

        return matchInfosValue
    }
//    func requestMatchInfos(urlBaseHead: UrlHeadPoint, matchIds: [String]) async throws -> [MatchInfo] {
//        
//        var matchInfosValue: [MatchInfo] = []
//        for matchId in matchIds {
//            do {
//                let aValue = try await requestMatchInfo(urlBaseHead: urlBaseHead, matchId: matchId)
//                matchInfosValue.append(aValue)
//            } catch {
//                // Handle error here
//                print("Error requesting match info: \(error)")
//            }
//        }
//        
//        return matchInfosValue
//    }
    
    
    
    func totalRequest(urlBaseHead: UrlHeadPoint, name: String) async throws {
        
       let aSummonerInfo =
        try await requestSummonerInfo(urlBaseHead: urlBaseHead, name: name)
        
        let encryptedSummonerId = aSummonerInfo.id
        async let fetchLeaguesInfo =
        try await requestLeaguesInfo(urlBaseHead: urlBaseHead, encryptedSummonerId: encryptedSummonerId)
        
        let puuid = aSummonerInfo.puuid
        async let fetchMatchIds =
        try await requestMatchList(urlBaseHead: urlBaseHead, puuid: puuid)
        
        let (leaguesInfo, matchIds) = try await (fetchLeaguesInfo, fetchMatchIds)
        
        let matchInfos =
        try await requestMatchInfos(urlBaseHead: urlBaseHead, matchIds: matchIds)
        
        
        self.summonerInfo = aSummonerInfo
        self.leagueInfo = leaguesInfo
        self.matchInfos = matchInfos
        
//        self.isLoading = false
    }

}

/* summonerInfoRequest()
         ApiClient.shared.session
             .request(Router.summoner(urlBaseHead: urlBaseHead, name: name))
             .publishDecodable(type: SummonerInfo.self)
             .map({ output in
                 debugPrint(output.error ?? "no error")
                 print("ResponseCode : \(String(describing: output.response?.statusCode))")
                 return output.value
             })
             .sink { completion in
                 print("Service - requestSummoner Info sink completion: \(completion)")
             } receiveValue: { [weak self] value in
                 self?.summonerInfo = value
             }
             .store(in: &subscription)
 */

/* summonerLeaguesRequest()
 ApiClient.shared.session
     .request(Router.league(urlBaseHead: urlBaseHead, encryptedSummonerId: encryptedSummonerId))
     .publishDecodable(type: [SummonersLeagueElement].self)
     .value()
     .sink { completion in
         print("Service - League Info sink completion: \(completion)")
     } receiveValue: { value in
         self.leagueInfo = value
     }
     .store(in: &subscription)
 */

/* matchListRequest()
 ApiClient.shared.session
     .request(Router.match(urlBaseHead: urlBaseHead, puuid: puuid))
     .publishDecodable(type: MatchIDs.self)
     .value()
     .sink { completion in
         print("Service - match Info sink completion: \(completion)")
     } receiveValue: { value in
         self.matchList.append(contentsOf: value)
     }
     .store(in: &subscription)
 */

/* matchInfoRequest()
 ApiClient.shared.session
     .request(Router.matchInfo(urlBaseHead: urlBaseHead, matchId: matchId))
     .publishDecodable(type: MatchInfo.self)
     .value()
     .sink { completion in
         print("Service - matchInfo Info sink completion: \(completion)")
     } receiveValue: { value in
         self.matchInfo = value
     }
     .store(in: &subscription)
 */

