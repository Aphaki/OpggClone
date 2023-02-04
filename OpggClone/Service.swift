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
    
    
    var subscription = Set<AnyCancellable>()
    
    func requestSummonerInfo(urlBaseHead: UrlHeadPoint, name: String) -> DataTask<SummonerInfo> {
        
        let dataTask =
        ApiClient.shared.session
            .request(Router.summoner(urlBaseHead: urlBaseHead, name: name))
            .serializingDecodable(SummonerInfo.self)
        
        return dataTask
    }
    
    func requestLeaguesInfo(urlBaseHead: UrlHeadPoint, encryptedSummonerId: String) async throws -> [SummonersLeagueElement] {
        let dataTask =
        ApiClient.shared.session
            .request(Router.league(urlBaseHead: urlBaseHead, encryptedSummonerId: encryptedSummonerId))
            .serializingDecodable([SummonersLeagueElement].self)
        
        let value = try await dataTask.value
        
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
        
//        var matchInfosValue: [MatchInfo] = []
//        for matchId in matchIds {
//            async let aValue = await requestMatchInfo(urlBaseHead: urlBaseHead, matchId: matchId)
//
//            try await matchInfosValue.append(aValue)
//        }
//
//        return matchInfosValue
        
        try await withThrowingTaskGroup(of: MatchInfo.self, body: { group in
            for matchId in matchIds {
                group.addTask { try await self.requestMatchInfo(urlBaseHead: urlBaseHead, matchId: matchId) }
            }
            var result = [MatchInfo]()
            
            for try await aMatchInfo in group {
                result.append(aMatchInfo)
            }
            return result
        })
    }
}

