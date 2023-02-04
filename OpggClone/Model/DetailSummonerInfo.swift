//
//  MySummonerInfo.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/01/31.
//

import Foundation

struct DetailSummonerInfo {
    
    let icon: Int
    let level: Int
    let summonerName: String
    let rank: String
    let tier: String
    let point: Int
    let mostChamp: [MostChamp]
    let winCount: Int
    let loseCount: Int
    let totalWinningRate: Int
    let totalKda: Double
    let summonerInfo: SummonerInfo
    let leagueInfos: [SummonersLeagueElement]
    let matchInfos: [MatchInfo]
    
}

struct MostChamp: Identifiable {
    let id = UUID()
    let championName: String
    let winningRate: Int
    let kda: Double
}
