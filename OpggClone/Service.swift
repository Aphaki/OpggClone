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
    @Published var leagueInfo: SummonersLeagueElement?
    @Published var matchList: MatchIDs = []
    @Published var matchInfos: [MatchInfo] = []
    @Published var matchInfo: MatchInfo?
    
//    let spellInfo: SummonerSpell = InstanceOfSummonerSpell.instance.spellInfo
    
    
    var subscription = Set<AnyCancellable>()
    
    private func requestSummonerInfo(urlBaseHead: UrlHeadPoint, name: String)  {
        ApiClient.shared.session
            .request(Router.summoner(urlBaseHead: urlBaseHead, name: name))
            .publishDecodable(type: SummonerInfo.self)
            .value()
            .sink { completion in
                print("Service - requestSummoner Info sink completion: \(completion)")
            } receiveValue: { value in
                self.summonerInfo = value
            }
            .store(in: &subscription)
    }
    private func requestLeagueInfo(urlBaseHead: UrlHeadPoint, encryptedSummonerId: String)  {
        ApiClient.shared.session
            .request(Router.league(urlBaseHead: urlBaseHead, encryptedSummonerId: encryptedSummonerId))
            .publishDecodable(type: SummonersLeagueElement.self)
            .value()
            .sink { completion in
                print("Service - League Info sink completion: \(completion)")
            } receiveValue: { value in
                self.leagueInfo = value
            }
            .store(in: &subscription)
    }
    private func requestMatchList(urlBaseHead: UrlHeadPoint, puuid: String)  {
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
    }
    private func requestMatchInfo(urlBaseHead: UrlHeadPoint, matchId: String)  {
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
    }
    
    func requestMatchInfos(urlBaseHead: UrlHeadPoint, matchIds: [String]) async {
            for matchId in matchIds {
                guard let aMatchInfo = await ApiClient.shared.session
                    .request(Router.matchInfo(urlBaseHead: urlBaseHead, matchId: matchId))
                    .serializingDecodable(MatchInfo.self)
                    .response
                    .value else { return }
                self.matchInfos.append(aMatchInfo)
            }
        }

    
    func totalRequest() {
        requestSummonerInfo(urlBaseHead: regionPicker, name: searchBarText)
        guard let summonerInfoG = summonerInfo else {
            print("summonerInfo 가 없음")
            return }
        requestLeagueInfo(urlBaseHead: regionPicker, encryptedSummonerId: summonerInfoG.name)
        requestMatchList(urlBaseHead: regionPicker, puuid: summonerInfoG.puuid)
        for matchid in matchList {
            requestMatchInfo(urlBaseHead: regionPicker, matchId: matchid)
        }
    }
    func getSummernerMatchInfo(summonerID: String) {
        
        let participant =
        matchInfo?.info.participants.first(where: { aParticipant in
           return aParticipant.summonerID == summonerID
        })
    }
}
