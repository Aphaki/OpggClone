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
    @Published var isLoading: Bool = false
    
    @Published var searchedDetail: DetailSummonerInfo?
    @Published var myDetailSummonerInfo: DetailSummonerInfo?
    @Published var searchedSummonersDetail: [DetailSummonerInfo] = []
    @Published var bookMarkSummonersDetail: [DetailSummonerInfo] = []
    
//    @Published var noSummonerError = PassthroughSubject<(),Never>()
    
    private var subscription = Set<AnyCancellable>()
    
    //
    func requestSummonerInfo(urlBaseHead: UrlHeadPoint, name: String) async throws -> SummonerInfo {
        try await NetworkManager.shared.requestSummonerInfo(urlBaseHead: urlBaseHead, name: name)
    }
    
    func requestLeaguesInfo(urlBaseHead: UrlHeadPoint, encryptedSummonerId: String) async throws -> [SummonersLeagueElement] {
        try await NetworkManager.shared.requestLeaguesInfo(urlBaseHead: urlBaseHead, encryptedSummonerId: encryptedSummonerId)
    }
    
    func requestMatchList(urlBaseHead: UrlHeadPoint, puuid: String, start: Int = 0, count: Int = 20) async throws -> [String]  {
        try await NetworkManager.shared.requestMatchList(urlBaseHead: urlBaseHead, puuid: puuid, start: start, count: count)
    }
    
    private func requestMatchInfo(urlBaseHead: UrlHeadPoint, matchId: String) async throws -> MatchInfo  {
        try await NetworkManager.shared.requestMatchInfo(urlBaseHead: urlBaseHead, matchId: matchId)
    }

    func requestMatchInfos(urlBaseHead: UrlHeadPoint, matchIds: [String]) async throws -> [MatchInfo] {
        
        try await NetworkManager.shared.requestMatchInfos(urlBaseHead: urlBaseHead, matchIds: matchIds)
    }
    
    
    
    func saveMyDetail(urlBase: UrlHeadPoint, name: String) async throws {
        
        await MainActor.run {
            isLoading = true
            print("isLoading true 가 불렸다, myDetailSummonerInfo: \(myDetailSummonerInfo.debugDescription)")
        }
        let value =
        try await fetchAndChangeToDetail(urlBase: urlBase, name: name)
        
        await MainActor.run {
            
            myDetailSummonerInfo = value
            isLoading = false
            print("isLoading false 가 불렸다, myDetailSummonerInfo: \(myDetailSummonerInfo.debugDescription)")
        }
    }
    
    func saveSearchedSummonerDetail(urlBase: UrlHeadPoint, name: String) async throws {
        await MainActor.run {
            self.isLoading = true
            
        }
        
        let searchedSummonerDetail =
        try await fetchAndChangeToDetail(urlBase: urlBase, name: name)
        
        await MainActor.run(body: {
            self.searchedDetail = searchedSummonerDetail
            
            self.isLoading = false
        })
        
    }
    
    func fetchAndChangeToDetail(urlBase:UrlHeadPoint, name: String) async throws -> DetailSummonerInfo {
        
        await MainActor.run {
            self.isLoading = true
            
        }
        
        let aSummonerInfo = try await requestSummonerInfo(urlBaseHead: urlBase, name: name)
        
        let encryptedSummonerId = aSummonerInfo.id
        async let fetchLeaguesInfo = await requestLeaguesInfo(urlBaseHead: urlBase, encryptedSummonerId: encryptedSummonerId)
        
        let puuid = aSummonerInfo.puuid
        async let fetchMatchIds =
        await requestMatchList(urlBaseHead: urlBase, puuid: puuid)
        
        let (leaguesInfo, matchIds) = try await (fetchLeaguesInfo, fetchMatchIds)
        
        let matchInfos =
        try await requestMatchInfos(urlBaseHead: urlBase, matchIds: matchIds)
        
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
        
        var winningRate: Int {
            if winCount+loseCount != 0 {
                return winCount * 100 / (winCount + loseCount)
            } else {
                return 0
            }
        }

       
        
        
        
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
        await MainActor.run(body: {
            
            self.isLoading = false
        })
        
        return detailSummonerInfo
        
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
        
        var most1winningRate: Int {
            if most1Wins + most1Losses == 0 {
                return 0
            } else {
                return most1Wins * 100 / (most1Wins + most1Losses)
            }
        }
        
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
        if secondMostFrequentElement != nil {
            frequencyDictionary.removeValue(forKey: secondMostFrequentElement!)
        }
        
        let thirdMaxFrequency = frequencyDictionary.values.max()
        let thirdMostFrequentElement = frequencyDictionary.first(where: { $0.value == thirdMaxFrequency })?.key
        
        return (mostFrequentElement ?? "", secondMostFrequentElement ?? "", thirdMostFrequentElement ?? "")
    }
    
    func duplicateCheckAndAdd(aDetailSummoner: DetailSummonerInfo, summonerList: inout [DetailSummonerInfo]) {
        let nameArray =
        summonerList.map { aDetail in
            return aDetail.summonerName
        }
        if nameArray.filter({ aName in
            return aName == aDetailSummoner.summonerName
        }).isEmpty {
            summonerList.append(aDetailSummoner)
        }
    }
    
//    func duplicateCheckAndAdd(aDetailSummoner: DetailSummonerInfo) {
//        let nameArray =
//        self.searchedSummonersDetail.map { aDetail in return aDetail.summonerName }
//
//        if nameArray.filter( { $0 == aDetailSummoner.summonerName} ).isEmpty {
//            self.searchedSummonersDetail.append(aDetailSummoner)
//        }
//    }
//    private func appIsLoadingTrue() async {
//        self.isLoading = true
//    }
//    private func appIsLoadingFalse() async {
//        self.isLoading = false
//    }
}
