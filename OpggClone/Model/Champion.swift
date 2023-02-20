//
//  Champion.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/02/20.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let champion = try? JSONDecoder().decode(Champion.self, from: jsonData)

import Foundation

// MARK: - Champion
struct Champion: Codable {
    let type: TypeEnum
    let format: String
    let version: Version
    let data: [String: ChampDatum]
}

// MARK: - Datum
struct ChampDatum: Codable {
    let version: Version
    let id, key, name, title: String
    let blurb: String
    let champInfo: ChampInfo
    let champImage: ChampImage
    let tags: [Tag]
    let partype: String
    let stats: [String: Double]
    
    enum CodingKeys: String, CodingKey {
        case version, id, key, name, title, blurb
        case champInfo = "info"
        case champImage = "image"
        case tags, partype, stats
    }
    
}

// MARK: - Image
struct ChampImage: Codable {
    let full: String
    let champSprite: ChampSprite
    let group: TypeEnum
    let x, y, w, h: Int
    
    enum CodingKeys: String, CodingKey {
        case full, group, x, y, w, h
        case champSprite = "sprite"
    }
}

enum TypeEnum: String, Codable {
    case champion = "champion"
}

enum ChampSprite: String, Codable {
    case champion0PNG = "champion0.png"
    case champion1PNG = "champion1.png"
    case champion2PNG = "champion2.png"
    case champion3PNG = "champion3.png"
    case champion4PNG = "champion4.png"
    case champion5PNG = "champion5.png"
}

// MARK: - Info
struct ChampInfo: Codable {
    let attack, defense, magic, difficulty: Int
}

enum Tag: String, Codable {
    case assassin = "Assassin"
    case fighter = "Fighter"
    case mage = "Mage"
    case marksman = "Marksman"
    case support = "Support"
    case tank = "Tank"
}

enum Version: String, Codable {
    case the12231 = "12.23.1"
}
