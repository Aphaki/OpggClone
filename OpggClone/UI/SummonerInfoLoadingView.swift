//
//  SummonerInfoLoadingView.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/01/21.
//

import SwiftUI

struct SummonerInfoLoadingView: View {
    
    @EnvironmentObject var mainVM: MainViewModel
    
    @Binding var summonerInfo: SummonerInfo?
    @Binding var leagues: [SummonersLeagueElement]
    @Binding var matchInfos: [MatchInfo]
    
    @Binding var goToSummonerInfoView: Bool
    
    
    
    var body: some View {
        if mainVM.isLoading == true {
            ProgressView()
                .frame(width: 200, height: 200, alignment: .center)
        } else if summonerInfo != nil {
            SummonerInfoView(summoner: summonerInfo!, leagues: leagues, matchInfos: matchInfos)
        } else {
            VStack {
                Text("소환사를 찾을 수 없습니다.")
                Button {
                    goToSummonerInfoView.toggle()
                } label: {
                    Text("Click")
                }

            }
            
                
        }
    }
}

//struct SummonerInfoLoadingView_Previews: PreviewProvider {
//    static var previews: some View {
//        SummonerInfoLoadingView(
//    }
//}
