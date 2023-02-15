//
//  MySummonerInfoView.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/02/01.
//

import SwiftUI

struct MySummonerLoadingView: View {

    let mySummonerInfo: DetailSummonerInfo?
    
    @Binding var regionPicker: UrlHeadPoint


    var body: some View {
        if mySummonerInfo != nil {
            SummonerInfoView(mostChamp: mySummonerInfo!.mostChamp.first!.championName, summoner: mySummonerInfo!.summonerInfo, leagues: mySummonerInfo!.leagueInfos, matchInfos: mySummonerInfo!.matchInfos, regionPicker: $regionPicker)
        } else {
            Text("네트워크 연결을 확인하세요.")
        }
    }
}
