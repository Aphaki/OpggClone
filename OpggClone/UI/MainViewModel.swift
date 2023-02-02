//
//  MainViewModel.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/01/08.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
    @Published var regionPicker: UrlHeadPoint = .kr
    @Published var searchBarText: String = ""
    
    @Published var summonerInfo: SummonerInfo?
    @Published var leagueInfo: [SummonersLeagueElement] = []
    @Published var matchList: MatchIDs = []
    @Published var matchInfos: [MatchInfo] = []
    
    @Published var isLoading: Bool = false
    
    @Published var mySummonerInfo: MySummonerInfo?
    
    private var service = Service()
    private var subscription = Set<AnyCancellable>()
    
    init() {
        totalSubscribe()
    }
    
    func fetchSummonerInfo(urlBase: UrlHeadPoint, name: String) async throws {
        
        DispatchQueue.main.schedule {
            self.isLoading = true
        }
        
       try await service.totalRequest(urlBaseHead: urlBase, name: name)
        
        DispatchQueue.main.schedule {
            self.isLoading = false
        }
    }
    
    func saveMySummonerInfo(urlBase:UrlHeadPoint, name: String) {
        Task {
            DispatchQueue.main.schedule {
                self.isLoading = true
            }
            
            
            let aSummonerInfo = try await service.requestSummonerInfo(urlBaseHead: urlBase, name: name)
            
            let encryptedSummonerId = aSummonerInfo.id
            async let fetchLeaguesInfo =
            try await service.requestLeaguesInfo(urlBaseHead: urlBase, encryptedSummonerId: encryptedSummonerId)
            
            let puuid = aSummonerInfo.puuid
            async let fetchMatchIds =
            try await service.requestMatchList(urlBaseHead: urlBase, puuid: puuid)
            
            let (leaguesInfo, matchIds) = try await (fetchLeaguesInfo, fetchMatchIds)
            
            let matchInfos =
            try await service.requestMatchInfos(urlBaseHead: urlBase, matchIds: matchIds)
            
            let soloRankLeague = leaguesInfo.first { aLeague in
                return aLeague.queueType == "RANKED_SOLO_5x5"
            }
            
            let mySummonerMatchInfos =
            matchInfos.map { (aMatch) -> Participant in
                let filteredParticipant =
                aMatch.info.participants.first { aParticipant in
                    return aParticipant.puuid == aSummonerInfo.puuid
                }
                return filteredParticipant!
            }
            let winCount =
            mySummonerMatchInfos.filter { aParticipant in
               return aParticipant.win == true
            }.count
            let loseCount = mySummonerMatchInfos.filter { aParticipant in
                return aParticipant.win == false
             }.count
            let winningRate = winCount * 100 / (winCount + loseCount)
            
            let totalKills =
            mySummonerMatchInfos.map { aParticipant -> Int in
               return aParticipant.kills
            }.reduce(0, +)
            let totalDeaths =
            mySummonerMatchInfos.map { aParticipant -> Int in
               return aParticipant.deaths
            }.reduce(0, +)
            let totalAssists =
            mySummonerMatchInfos.map { aParticipant -> Int in
               return aParticipant.assists
            }.reduce(0, +)
            let totalKda = (Double(totalKills) + Double(totalAssists)) / Double(totalDeaths)
//            let kdaString = totalKda.with2Demicals() + ":1"
            
            let champNameArray =
            mySummonerMatchInfos.map { aParticipant in
               return aParticipant.championName
            }
            let (most1Champ, most2Champ, most3Champ) = filteredMost(champNameArray: champNameArray)
            let (most1WinningRate, most1Kda) = makeWinningRateAndKda(champName: most1Champ, mySummonerMatchInfos: mySummonerMatchInfos)
            let (most2WinningRate, most2Kda) = makeWinningRateAndKda(champName: most2Champ, mySummonerMatchInfos: mySummonerMatchInfos)
            let (most3WinningRate, most3Kda) = makeWinningRateAndKda(champName: most3Champ, mySummonerMatchInfos: mySummonerMatchInfos)
            
            
            let firstChamp = MostChamp(championName: most1Champ, winningRate: most1WinningRate, kda: most1Kda)
            let secondChamp = MostChamp(championName: most2Champ, winningRate: most2WinningRate, kda: most2Kda)
            let thirdChamp = MostChamp(championName: most3Champ, winningRate: most3WinningRate, kda: most3Kda)
            
            
            let mySummonerInfo =
            MySummonerInfo(icon: aSummonerInfo.profileIconId,
                           level: aSummonerInfo.summonerLevel,
                           summonerName: aSummonerInfo.name,
                           rank: soloRankLeague?.rank ?? "-",
                           tier: soloRankLeague?.tier ?? "-",
                           point: soloRankLeague?.leaguePoints ?? 0,
                           mostChamp:[firstChamp, secondChamp, thirdChamp] ,
                           winCount: winCount,
                           loseCount: loseCount,
                           totalWinningRate: winningRate,
                           totalKda: totalKda)
            DispatchQueue.main.schedule {
                self.mySummonerInfo = mySummonerInfo
                self.isLoading = false
            }
        }
    }
    private func makeWinningRateAndKda(champName: String, mySummonerMatchInfos: [Participant]) -> (Int, Double){
        let most1matchInfos =
        mySummonerMatchInfos.filter { aParticipant in
           return aParticipant.championName == champName
        }
        let most1Wins =
        most1matchInfos.filter { aParticipant in
            return aParticipant.win == true
        }.count
        let most1Losses =
        most1matchInfos.filter { aParticipant in
            return aParticipant.win == false
        }.count
        let most1winningRate = most1Wins * 100 / (most1Wins + most1Losses)
        
        let most1Kills =
        most1matchInfos.map { aParticipant -> Int in
            return aParticipant.kills
        }.reduce(0, +)
        let most1Deaths =
        most1matchInfos.map { aParticipant -> Int in
            return aParticipant.deaths
        }.reduce(0, +)
        let most1Assists =
        most1matchInfos.map { aParticipant -> Int in
            return aParticipant.assists
        }.reduce(0, +)
        let most1kda =  Double(most1Kills + most1Assists) / Double(most1Deaths)
//        let most1KdaString = most1kda.with2Demicals() + ":1"
        
        return (most1winningRate, most1kda)
    }
    
    private func filteredMost(champNameArray: [String]) -> (String, String, String) {
        var frequencyDictionary = [String: Int]()

        for element in champNameArray {
            if let count = frequencyDictionary[element] {
                frequencyDictionary[element] = count + 1
            } else {
                frequencyDictionary[element] = 1
            }
        }

        let maxFrequency = frequencyDictionary.values.max()
        let mostFrequentElement = frequencyDictionary.first(where: { $0.value == maxFrequency })?.key

        frequencyDictionary.removeValue(forKey: mostFrequentElement!)

        let secondMaxFrequency = frequencyDictionary.values.max()
        let secondMostFrequentElement = frequencyDictionary.first(where: { $0.value == secondMaxFrequency })?.key

        frequencyDictionary.removeValue(forKey: secondMostFrequentElement!)

        let thirdMaxFrequency = frequencyDictionary.values.max()
        let thirdMostFrequentElement = frequencyDictionary.first(where: { $0.value == thirdMaxFrequency })?.key
        
        return (mostFrequentElement ?? "", secondMostFrequentElement ?? "", thirdMostFrequentElement ?? "")
    }
    
    //MARK: - 구독
    private func subscribeUrlRegion() {
        service.$regionPicker
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("subscribeUrlRegion subscribe completion: \(completion)")
            } receiveValue: { urlHeadPoint in
                self.regionPicker = urlHeadPoint
            }
            .store(in: &subscription)
    }
    private func subscribeSearchBarText() {
        service.$searchBarText
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("subscribeSearchBarText subscribe completion: \(completion)")
            } receiveValue: { receivedValue in
                self.searchBarText = receivedValue
            }
            .store(in: &subscription)
    }
    private func subscribeSummonerInfo() {
        service.$summonerInfo
            .receive(on: DispatchQueue.main)
            .sink { [weak self] receivedInfo in
                self?.summonerInfo = receivedInfo
            }
            .store(in: &subscription)
    }
    private func subscribeLeagueInfo() {
        service.$leagueInfo
            .receive(on: DispatchQueue.main)
            .sink { [weak self] receivedInfo in
                self?.leagueInfo = receivedInfo
            }
            .store(in: &subscription)
    }
    private func subscribeMatchList() {
        service.$matchList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] receivedList in
                self?.matchList = receivedList
            }
            .store(in: &subscription)
    }
    private func subscribeMatchInfos() {
        service.$matchInfos
            .receive(on: DispatchQueue.main)
            .sink { [weak self] receivedList in
                self?.matchInfos = receivedList
            }
            .store(in: &subscription)
    }
//    private func subscribeIsLoading() {
//        service.$isLoading
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] receivedBool in
//                self?.isLoading = receivedBool
//            }
//            .store(in: &subscription)
//    }
    
    private func totalSubscribe() {
        subscribeUrlRegion()
        subscribeSearchBarText()
        subscribeSummonerInfo()
        subscribeLeagueInfo()
        subscribeMatchList()
        subscribeMatchInfos()
//        subscribeIsLoading()
    }
//    func totalRequest() {
//        service.totalRequest()
//    }
    
    
}
