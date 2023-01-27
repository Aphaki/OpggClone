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
    let accountId: String
    let puuid: String
    let name: String
    let profileIconId: Int
    let revisionDate: Int
    let summonerLevel: Int
    
    enum CodingKeys: String, CodingKey {
        case id, accountId, puuid, name, profileIconId, revisionDate, summonerLevel
    }
}
/*
 {
     "id": "fcx3E-srnYM_nLY1WP5_0nxaFPR4bs8kF7Xrms7iFBgVxw",
     "accountId": "0iQI_8k4uSjaBh1B9Nvya6mws4OAZ8Bi2obQg5dX41N6",
     "puuid": "YwT0WdYDJHwg9Xr525J2W-DgOgmKZdBD_1WCDLrDHWYic-8fctB_JX3jKH-AuFdYNPOHJOz8IqZ2pg",
     "name": "용용J",
     "profileIconId": 3160,
     "revisionDate": 1674298690460,
     "summonerLevel": 477
 }
 */
