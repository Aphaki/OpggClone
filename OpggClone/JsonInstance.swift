//
//  InstanceOfSummonerSpell.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/01/14.
//

import Foundation

class JsonInstance {
    static let shared = JsonInstance()
    
    var runeStore: [RunesReforgedElement] {
        guard let fileUrl = Bundle.main.url(forResource: "runesReforged", withExtension: "json") else {
            fatalError("runesReforged.json not found")
        }
        let decoder = JSONDecoder()
        do {
            let jsonData = try Data(contentsOf: fileUrl)
            do {
                let runesDetail = try decoder.decode([RunesReforgedElement].self, from: jsonData)
                return runesDetail
            } catch {
                print("runesReforged jsonData Decode Error")
            }
            
        } catch {
            print("runesReforged fileUrl not found")
        }
        
        return []
    }
    
    var primaryRuneDic: [Int:String] {
        let runesDetail = runeStore
        var dic = [Int:String]()
        for aRune in runesDetail {
            dic[aRune.id] = aRune.icon
        }
        return dic
    }
    var detailRuneDic: [Int:String] {
        let runeDetails = runeStore.flatMap { element in
            return element.slots
        }
        let runes = runeDetails.flatMap { slot in
            return slot.runes
        }
        var dic = [Int:String]()
        for rune in runes {
            dic[rune.id] = rune.key
        }
        return dic
    }
    
    var spellStore: [String:String] {
        guard let fileUrl = Bundle.main.url(forResource: "summoner", withExtension: "json") else {
            fatalError("summoner.json not found")
        }
        let decoder = JSONDecoder()
        do {
            let jsonData = try Data(contentsOf: fileUrl)
            do {
                let spellDetail = try decoder.decode(SummonerSpells.self, from: jsonData)
                let data = spellDetail.data.map { (_, value) in

                    return value
                }
                var dic = [String:String]()
                for spell in data {
                    dic[spell.key] = spell.id
                }
                return dic
            } catch {
                print("SummonerSpell jsonData Decode Error")
            }
            
        } catch {
            print("SummonerSpell fileUrl not found")
        }
        
        return [:]
    }
    
}
