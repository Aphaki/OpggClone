//
//  SearchInfoViewModel.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/02/15.
//

import Foundation

class SearchInfoViewModel: ObservableObject {
    
    @Published var mostChamp: String
    @Published var summoner: SummonerInfo
    @Published var leagues: [SummonersLeagueElement]
    @Published var matchInfos: [MatchInfo]
    
    @Published var regionPicker: UrlHeadPoint
    
    @Published var addLoading: Bool = false
    
    let queueTypeDic: [String:String] = JsonInstance.shared.queueType
    
    var matchIndex = 15
    let AddInfoCount: Int = 5
    
    init(mostChamp: String, summoner: SummonerInfo, leagues: [SummonersLeagueElement], matchInfos: [MatchInfo], regionPicker: UrlHeadPoint) {
        self.mostChamp = mostChamp
        self.summoner = summoner
        self.leagues = leagues
        self.matchInfos = matchInfos
        self.regionPicker = regionPicker
    }
    
    func requestAdditionalMatchList(urlBaseHead: UrlHeadPoint, puuid: String, start: Int, count: Int) async throws -> [String]  {
        let dataTask = ApiClient.shared.session
            .request(Router.match(urlBaseHead: urlBaseHead, puuid: puuid, start: start, count: count))
            .serializingDecodable([String].self)
        
        if let response = await dataTask.response.response {
            
            print("SearchInfoViewModel - requestMatchList() - Status Code: \(response.statusCode)")
        } else {
            
            print("SearchInfoViewModel - requestMatchList() - response: nil")
        }
        
        do {
            let value = try await dataTask.value
            return value
        } catch let error {
            debugPrint(error.localizedDescription)
            throw error
        }
    }
    private func requestMatchInfo(urlBaseHead: UrlHeadPoint, matchId: String) async throws -> MatchInfo  {
        let dataTask = ApiClient.shared.session
            .request(Router.matchInfo(urlBaseHead: urlBaseHead, matchId: matchId))
            .serializingDecodable(MatchInfo.self)

        
        if let response = await dataTask.response.response {
            
            print("SearchInfoViewModel - requestMatchInfo() - Status Code: \(response.statusCode), url: \(String(describing: response.url?.debugDescription))")
            if response.statusCode == 429 {
               dataTask.resume()
            }
        } else {
            
            print("SearchInfoViewModel - requestMatchInfo() - response: nil")
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
    func addAdditionalInfo(start: Int, count: Int) {
        
        
        Task {
            await MainActor.run(body: {
                self.addLoading.toggle()
                print("addLoading: \(addLoading)")
            })
            let matchIdArray =
            try await requestAdditionalMatchList(urlBaseHead: regionPicker, puuid: summoner.puuid, start: start, count: count)
            let additionalMatchInfos =
            try await requestMatchInfos(urlBaseHead: regionPicker, matchIds: matchIdArray)
            
            await MainActor.run {
                self.matchInfos.append(contentsOf: additionalMatchInfos)
            }
            await MainActor.run(body: {
                self.addLoading.toggle()
                print("addLoading: \(addLoading)")

            })
        }
    }
    
}
