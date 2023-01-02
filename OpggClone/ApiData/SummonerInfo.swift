//
//  SummonerInfo.swift
//  OpggClone
//
//  Created by Sy Lee on 2022/12/26.
//

import Foundation

// need summoner name -> 유저가 입력

struct SummonerInfo: Codable {
    let id: String
    let accountID: String
    let puuid: String
    let name: String
    let profileIconId: Int
    let revisionDate: Int
    let summonerLevel: Int
}
