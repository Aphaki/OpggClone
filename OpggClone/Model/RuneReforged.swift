//
//  RuneReforged.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/01/18.
//

import Foundation

// MARK: - RunesReforgedElement
struct RunesReforgedElement: Codable {
    let id: Int
    let key, icon, name: String
    let slots: [Slot]
}

// MARK: - Slot
struct Slot: Codable {
    let runes: [Rune]
}

// MARK: - Rune
struct Rune: Codable {
    let id: Int
    let key, icon, name, shortDesc: String
    let longDesc: String
}

typealias RunesReforged = [RunesReforgedElement]
