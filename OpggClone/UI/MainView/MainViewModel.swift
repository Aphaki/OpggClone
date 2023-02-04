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
    
    @Published var isLoading: Bool = false
    
    @Published var searchedDetail: DetailSummonerInfo?
    @Published var myDetailSummonerInfo: DetailSummonerInfo?
    
    var searchedSummonerDetail: [DetailSummonerInfo] = []
    
    private var service = Service()
    private var subscription = Set<AnyCancellable>()
    
    init() {
        totalSubscribe()
    }
    
//    func fetchSummonerInfo(urlBase: UrlHeadPoint, name: String) async throws {
//
//        DispatchQueue.main.schedule {
//            self.isLoading = true
//        }
//
//       try await service.totalRequest(urlBaseHead: urlBase, name: name)
//
//        DispatchQueue.main.schedule {
//            self.isLoading = false
//        }
//    }
    func saveMyDetail(urlBase: UrlHeadPoint, name: String) {
        
        Task {
            DispatchQueue.main.schedule {
                self.isLoading = true
            }
            let myDetail =
           try await fetchAndChangeToDetail(urlBase: self.regionPicker ,name: name)
            DispatchQueue.main.schedule {
                self.myDetailSummonerInfo = myDetail
                self.isLoading = false
            }
        }
    }
    
    func saveSearchedDetail(urlBase: UrlHeadPoint, name: String) {
        
        Task {
            DispatchQueue.main.schedule {
                self.isLoading = true
            }
            let searchedSummonerDetail =
           try await fetchAndChangeToDetail(urlBase: self.regionPicker ,name: name)
            DispatchQueue.main.schedule {
                self.searchedDetail = searchedSummonerDetail
                self.isLoading = false
            }
        }
    }
    
    func fetchAndChangeToDetail(urlBase:UrlHeadPoint, name: String) async throws -> DetailSummonerInfo {

        let summonerInfoDataTask = service.requestSummonerInfo(urlBaseHead: urlBase, name: name)
        
        if let response = await summonerInfoDataTask.response.response {
            // 404 Not Found -> 없는 소환사
            print("MainViewModel - fetchAndChangeToDetail() - Status Code: \(response.statusCode)")
        } else {
            //통신x
            print("MainViewModel - fetchAndChangeToDetail() - response: nil")
        }
        
        let aSummonerInfo = try await summonerInfoDataTask.value
            
            let encryptedSummonerId = aSummonerInfo.id
            async let fetchLeaguesInfo = await service.requestLeaguesInfo(urlBaseHead: urlBase, encryptedSummonerId: encryptedSummonerId)
            
            let puuid = aSummonerInfo.puuid
            async let fetchMatchIds =
             await service.requestMatchList(urlBaseHead: urlBase, puuid: puuid)
            
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
            
            
            let detailSummonerInfo =
       try await DetailSummonerInfo(icon: aSummonerInfo.profileIconId,
                           level: aSummonerInfo.summonerLevel,
                           summonerName: aSummonerInfo.name,
                           rank: soloRankLeague?.rank ?? "",
                           tier: soloRankLeague?.tier ?? "provisional",
                           point: soloRankLeague?.leaguePoints ?? 0,
                           mostChamp:[firstChamp, secondChamp, thirdChamp] ,
                           winCount: winCount,
                           loseCount: loseCount,
                           totalWinningRate: winningRate,
                           totalKda: totalKda,
                           summonerInfo: aSummonerInfo,
                           leagueInfos: fetchLeaguesInfo,
                           matchInfos: matchInfos)

            
            return detailSummonerInfo
//        }
        
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
    
    
//    private func duplicateCheck(name: String, summonerList: [DetailSummonerInfo]) {
//        let nameArray =
//        summonerList.map { aSummoner -> String in
//           return aSummoner.summonerName
//        }
//
//
//    }
    
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

    
    private func totalSubscribe() {
        subscribeUrlRegion()
        subscribeSearchBarText()

    }

    
}
