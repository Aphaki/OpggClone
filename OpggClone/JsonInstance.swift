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
            dic[rune.id] = rune.icon
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
    var queueType: [String:String] = ["RANKED_SOLO_5x5":"개인/2인 랭크", "RANKED_FLEX_SR":"자유랭크", "420":"개인/2인 랭크", "430":"일반" , "440":"자유랭크", "450":"무작위 총력전"]
    
    //MARK: - queueId Dictionary
    
    var queueIdArray: [QueueIdElement] {
        guard let fileUrl = Bundle.main.url(forResource: "queueId", withExtension: "json") else {
            fatalError("queueId.json not found")
        }
        let decoder = JSONDecoder()
        do {
           let jsonData = try Data(contentsOf: fileUrl)
            do {
                let queueIdArray =  try decoder.decode([QueueIdElement].self, from: jsonData)
                return queueIdArray
            } catch {
                print("queueId jsonData Decode Error")
            }
        } catch {
            print("queueId fileUrl not found")
        }
        return []
    }
    var dicQueueIdAndType: [Int:String] {
        var myDic = [Int:String]()
        queueIdArray.forEach { aQueueid in
            myDic[aQueueid.queueId] = aQueueid.description
        }
        return myDic
    }
    
    var dicQueueIdAndMap: [Int:String] {
        var myDic = [Int:String]()
        queueIdArray.forEach { aQueueid in
            myDic[aQueueid.queueId] = aQueueid.map
        }
        return myDic
    }
    //MARK: - Champion Dictionary
    
    var champDicArray: [ChampDatum] {
        guard let fileUrl = Bundle.main.url(forResource: "champion", withExtension: "json") else {
            fatalError("champion.json not found")
        }
        let decoder = JSONDecoder()
        do {
          let jsonData = try Data(contentsOf: fileUrl)
            do {
                let championDic =  try decoder.decode(Champion.self, from: jsonData)
                let value =
                championDic.data.map { (k,v) -> ChampDatum in
                    return v
                }
                
                return value
            } catch {
                print("champion jsonData Decode Error")
            }
        } catch {
            print("champion fileUrl not found")
        }
        return []
    }
    var champKeyToId: [String:String] {
        var myDic = [String:String]()
        champDicArray.forEach { aValue in
            myDic[aValue.key] = aValue.id
        }
        return myDic
    }
}
