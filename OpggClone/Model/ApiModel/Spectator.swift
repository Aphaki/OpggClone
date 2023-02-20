//
//  Spectator.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/02/17.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let spectator = try? JSONDecoder().decode(Spectator.self, from: jsonData)

import Foundation

// MARK: - Spectator
struct Spectator: Codable {
    let gameID, mapID: Int
    let gameMode, gameType: String
    let gameQueueConfigID: Int
    let spParticipants: [SpParticipant]
    let observers: Observers
    let platformID: String
    let bannedChampions: [BannedChampion]
    let gameStartTime, gameLength: Int

    enum CodingKeys: String, CodingKey {
        case gameID = "gameId"
        case mapID = "mapId"
        case gameMode, gameType
        case gameQueueConfigID = "gameQueueConfigId"
        case spParticipants = "participants"
        case observers
        case platformID = "platformId"
        case bannedChampions, gameStartTime, gameLength
    }
}

// MARK: - BannedChampion
struct BannedChampion: Codable {
    let championID, teamID, pickTurn: Int

    enum CodingKeys: String, CodingKey {
        case championID = "championId"
        case teamID = "teamId"
        case pickTurn
    }
}

// MARK: - Observers
struct Observers: Codable {
    let encryptionKey: String
}

// MARK: - Participant
struct SpParticipant: Identifiable ,Codable {
    let id = UUID()
    let teamID, spell1ID, spell2ID, championID: Int
    let profileIconID: Int
    let summonerName: String
    let bot: Bool
    let summonerID: String
    let gameCustomizationObjects: [String]
    let spPerks: SpPerks

    enum CodingKeys: String, CodingKey {
        case teamID = "teamId"
        case spell1ID = "spell1Id"
        case spell2ID = "spell2Id"
        case championID = "championId"
        case profileIconID = "profileIconId"
        case summonerName, bot
        case summonerID = "summonerId"
        case gameCustomizationObjects
        case spPerks = "perks"
    }
}

// MARK: - Perks
struct SpPerks: Codable {
    let perkIDS: [Int]
    let perkStyle, perkSubStyle: Int

    enum CodingKeys: String, CodingKey {
        case perkIDS = "perkIds"
        case perkStyle, perkSubStyle
    }
}

