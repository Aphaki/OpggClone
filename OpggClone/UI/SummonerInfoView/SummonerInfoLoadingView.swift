//
//  SummonerInfoLoadingView.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/01/21.
//

import SwiftUI

struct SummonerInfoLoadingView: View {
    
    @EnvironmentObject var mainVM: MainViewModel
    
    let searchedDetail: DetailSummonerInfo?
    
    var summonerInfo: SummonerInfo? {
        return self.searchedDetail?.summonerInfo ?? nil
    }
    var leagues: [SummonersLeagueElement] {
        return self.searchedDetail?.leagueInfos ?? []
    }
    var matchInfos: [MatchInfo] {
        return self.searchedDetail?.matchInfos ?? []
    }
    
    
    @Binding var goToSummonerInfoView: Bool
    
    
    
    var body: some View {
        if mainVM.isLoading == true {
            ProgressView()
                .frame(width: 200, height: 200, alignment: .center)
        } else if searchedDetail != nil {
            SummonerInfoView(summoner: summonerInfo!, leagues: leagues, matchInfos: matchInfos)
                .onAppear {
                    let value =
                    mainVM.searchedSummonersDetail.map { aSummoner in
                        return aSummoner.isBookMark
                    }
                    print("SummonerInfoLoadingView - searchedSummonersDetail is Bool:  " + value.description)
                }
            
        }
//        else {
//            VStack {
//                Text("소환사를 찾을 수 없습니다.")
//                Button {
//                    goToSummonerInfoView.toggle()
//
//                } label: {
//                    Text("Click")
//                }
//
//            }
//        }
    }
}

//struct SummonerInfoLoadingView_Previews: PreviewProvider {
//    static var previews: some View {
//        SummonerInfoLoadingView(
//    }
//}
