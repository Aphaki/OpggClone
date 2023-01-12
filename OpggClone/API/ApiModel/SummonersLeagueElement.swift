//
//  SummonersLeague.swift
//  OpggClone
//
//  Created by Sy Lee on 2022/12/26.
//

import Foundation

// Need encryptedSummonerId -> SummonerInfo 결과에서 얻음

// MARK: - SummonersLeagueElement
struct SummonersLeagueElement: Codable, Identifiable {
    var id = UUID()
    
    let leagueID, queueType, tier, rank: String
    let summonerID, summonerName: String
    let leaguePoints, wins, losses: Int
    let veteran, inactive, freshBlood, hotStreak: Bool
    
    var winRates: Int {
        return wins * 100 / (wins + losses)
    }

    enum CodingKeys: String, CodingKey {
        case leagueID = "leagueId"
        case queueType, tier, rank
        case summonerID = "summonerId"
        case summonerName, leaguePoints, wins, losses, veteran, inactive, freshBlood, hotStreak
    }
}

typealias SummonersLeague = [SummonersLeagueElement]

