//
//  SearchInfoViewModel.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/02/15.
//

import Foundation
import Combine

class SearchInfoViewModel: ObservableObject {
    
    @Published var mostChamp: String
    @Published var summoner: SummonerInfo
    @Published var leagues: [SummonersLeagueElement]
    @Published var matchInfos: [MatchInfo]
    @Published var spectator: Spectator?
    
    @Published var regionPicker: UrlHeadPoint
    
    @Published var noIngameError = PassthroughSubject<(),Never>()
    @Published var addLoading: Bool = false
    @Published var inGameLoading: Bool = false
    @Published var goInGameView: Bool = false
    
    let queueTypeDic: [String:String] = JsonInstance.shared.queueType
    
    var matchIndex = 15
    let AddInfoCount: Int = 5
    
    init(mostChamp: String, summoner: SummonerInfo, leagues: [SummonersLeagueElement], matchInfos: [MatchInfo], regionPicker: UrlHeadPoint) {
        self.mostChamp = mostChamp
        self.summoner = summoner
        self.leagues = leagues
        self.matchInfos = matchInfos
        self.regionPicker = regionPicker
        self.subscribeNoIngameError()
    }
    private func subscribeNoIngameError() {
        let _ =
        NetworkManager.shared.$noIngameError
//            .receive(on: DispatchQueue.main)
            .sink { value in
                self.noIngameError = value
            }
    }
    
    private func requestAdditionalMatchList(urlBaseHead: UrlHeadPoint, puuid: String, start: Int, count: Int) async throws -> [String]  {
        try await NetworkManager.shared.requestMatchList(urlBaseHead: urlBaseHead, puuid: puuid, start: start, count: count)
    }
    
    private func requestMatchInfos(urlBaseHead: UrlHeadPoint, matchIds: [String]) async throws -> [MatchInfo] {
        
       try await NetworkManager.shared.requestMatchInfos(urlBaseHead: urlBaseHead, matchIds: matchIds)
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
    
    func requestInGameSpectator(urlBaseHead: UrlHeadPoint, encryptedSummonerId: String) async throws -> Spectator {
        try await NetworkManager.shared.requestInGameSpectator(urlBaseHead: urlBaseHead, encryptedSummonerId: encryptedSummonerId)
        
    }
    func clickInGameInfo(urlBaseHead: UrlHeadPoint, encryptedSummonerId: String) {
        Task {
            await MainActor.run {
                self.inGameLoading = true
            }
            
            let speValue =
            try await NetworkManager.shared.requestInGameSpectator(urlBaseHead: urlBaseHead, encryptedSummonerId: encryptedSummonerId)
            
            await MainActor.run {
                self.spectator = speValue
                self.inGameLoading = false
                self.goInGameView = true
            }
        }
    }
    
}
