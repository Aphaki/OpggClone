//
//  NetworkManager.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/02/21.
//

import Foundation
import Combine

class NetworkManager {
    
    static let shared = NetworkManager()
    @Published var noSummonerError = PassthroughSubject<(),Never>()
    @Published var noIngameError = PassthroughSubject<(),Never>()
    
    func requestSummonerInfo(urlBaseHead: UrlHeadPoint, name: String) async throws -> SummonerInfo {
        
        let dataTask =
        ApiClient.shared.session
            .request(Router.summoner(urlBaseHead: urlBaseHead, name: name))
            .serializingDecodable(SummonerInfo.self)
        if let response = await dataTask.response.response {
            // 404 Not Found -> 없는 소환사
            
            print("NetworkManager - requestSummonerInfo() - Status Code: \(response.statusCode)")
            if response.statusCode == 404 {
                await MainActor.run {
                    self.noSummonerError.send()
                }
            }
        } else {
            //통신x
            print("NetworkManager - requestSummonerInfo() - response: nil")
        }
        do {
            let value = try await dataTask.value
            return value
        } catch let error {
            debugPrint(error.localizedDescription)
            throw error
        }
    }
    
    func requestLeaguesInfo(urlBaseHead: UrlHeadPoint, encryptedSummonerId: String) async throws -> [SummonersLeagueElement] {
        let dataTask =
        ApiClient.shared.session
            .request(Router.league(urlBaseHead: urlBaseHead, encryptedSummonerId: encryptedSummonerId))
            .serializingDecodable([SummonersLeagueElement].self)
        
        if let response = await dataTask.response.response {
            
            print("NetworkManager - requestLeaguesInfo() - Status Code: \(response.statusCode)")
        } else {
            
            print("NetworkManager - requestLeaguesInfo() - response: nil")
        }
        
        do {
            let value = try await dataTask.value
            return value
        } catch let error {
            debugPrint(error.localizedDescription)
            throw error
        }
    }
    
    func requestMatchList(urlBaseHead: UrlHeadPoint, puuid: String, start: Int = 0, count: Int = 20) async throws -> [String]  {
        let dataTask = ApiClient.shared.session
            .request(Router.match(urlBaseHead: urlBaseHead, puuid: puuid, start: start, count: count))
            .serializingDecodable([String].self)
        
        if let response = await dataTask.response.response {
            
            print("NetworkManager - requestMatchList() - Status Code: \(response.statusCode)")
        } else {
            
            print("NetworkManager - requestMatchList() - response: nil")
        }
        
        do {
            let value = try await dataTask.value
            return value
        } catch let error {
            debugPrint(error.localizedDescription)
            throw error
        }
    }
    
    func requestMatchInfo(urlBaseHead: UrlHeadPoint, matchId: String) async throws -> MatchInfo  {
        let dataTask = ApiClient.shared.session
            .request(Router.matchInfo(urlBaseHead: urlBaseHead, matchId: matchId))
            .serializingDecodable(MatchInfo.self)

        
        if let response = await dataTask.response.response {
            
            print("NetworkManager - requestMatchInfo() - Status Code: \(response.statusCode), url: \(String(describing: response.url?.debugDescription))")
            if response.statusCode == 429 {
               dataTask.resume()
            }
        } else {
            
            print("NetworkManager - requestMatchInfo() - response: nil")
        }
        
        do {
            let value = try await dataTask.value
            return value
        } catch let error {
            debugPrint(error.localizedDescription)
            throw error
        }
    }
    
    func requestInGameSpectator(urlBaseHead: UrlHeadPoint, encryptedSummonerId: String) async throws -> Spectator {
        let dataTask =
        ApiClient.shared.session
            .request(Router.inGameInfo(urlBaseHead: urlBaseHead, encryptedSummonerId: encryptedSummonerId))
            .serializingDecodable(Spectator.self)
        
        if let response = await dataTask.response.response {
            
            print("NetworkManager - requestInGameSpectator() - Status Code: \(response.statusCode), url: \(String(describing: response.url?.debugDescription))")
            if response.statusCode == 404 {
                await MainActor.run(body: {
                    self.noIngameError.send()

                })
            }
            
        } else {
            
            print("NetworkManager - requestInGameSpectator() - response: nil")
        }
        
        do {
            let value = try await dataTask.value
            return value
        } catch let error {
            debugPrint(error.localizedDescription)
            throw error
        }
    }
    
    func requestMatchInfos(urlBaseHead: UrlHeadPoint, matchIds: [String]) async throws -> [MatchInfo] {
        
        let value =
        try await withThrowingTaskGroup(of: MatchInfo.self, body: { group in
            for matchId in matchIds {
                group.addTask { try await self.requestMatchInfo(urlBaseHead: urlBaseHead, matchId: matchId)
                    
                }
            }
            
            var result = [MatchInfo]()

            for try await aMatchInfo in group {
                result.append(aMatchInfo)
            }
            return result
        })
        return value.sorted { matchA, matchB in
           return matchA.info.gameStartTimestamp > matchB.info.gameStartTimestamp
        }
    }
}
