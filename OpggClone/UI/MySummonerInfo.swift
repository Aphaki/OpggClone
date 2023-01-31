//
//  MySummonerInfo.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/01/31.
//

import Foundation

struct MySummonerInfo {
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
    let totalKda: String // ex 1.32:1
}

struct MostChamp {
    let championName: String
    let winningRate: Int // or Int
    let kda: String // ex) 1.32:1
}
