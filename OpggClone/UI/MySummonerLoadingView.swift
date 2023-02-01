//
//  MySummonerInfoView.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/02/01.
//

import SwiftUI

struct MySummonerLoadingView: View {
    
    @EnvironmentObject var mainVM: MainViewModel
    
    @Binding var summonerInfo: SummonerInfo?
    @Binding var leagues: [SummonersLeagueElement]
    @Binding var matchInfos: [MatchInfo]
    
    var body: some View {
        if mainVM.isLoading == true {
            ProgressView()
                .frame(width: 200, height: 200, alignment: .center)
        } else if summonerInfo != nil {
            SummonerInfoView(summoner: summonerInfo!, leagues: leagues, matchInfos: matchInfos)
        } else {
            Text("네트워크 연결을 확인하세요.")
        }
    }
}
