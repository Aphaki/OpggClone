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
    
    var summonerInfo: SummonerInfo?
    var leagueInfo: SummonersLeagueElement?
    var matchList: MatchIDs = []
    var matchInfo: MatchInfo?
    
    var subscription = Set<AnyCancellable>()
    
    func requestSummonerInfo(urlBaseHead: UrlHeadPoint, name: String) {
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
    func requestLeagueInfo(urlBaseHead: UrlHeadPoint, encryptedSummonerId: String) {
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
    func requestMatchList(urlBaseHead: UrlHeadPoint, puuid: String) {
        ApiClient.shared.session
            .request(Router.match(urlBaseHead: urlBaseHead, puuid: puuid))
            .publishDecodable(type: MatchIDs.self)
            .value()
            .sink { completion in
                print("Service - match Info sink completion: \(completion)")
            } receiveValue: { value in
                self.matchList = value
            }
            .store(in: &subscription)
    }
    func requestMatchInfo(urlBaseHead: UrlHeadPoint, matchId: String) {
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
    
}
