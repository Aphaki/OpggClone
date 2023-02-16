//
//  SummonerInfoLoadingView.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/01/21.
//

import SwiftUI

struct SummonerInfoLoadingView: View {
    
    @EnvironmentObject var mainVM: MainViewModel
    
//    @Environment(\.dismiss) var dismiss
    
    let searchedDetail: DetailSummonerInfo?
    
    var mostChamp: String? {
        return self.searchedDetail?.mostChamp.first?.championName ?? ""
    }
    
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
    @Binding var regionPicker: UrlHeadPoint
    
    
    var body: some View {
        if mainVM.isLoading == true {
            ProgressView()
                .frame(width: 200, height: 200, alignment: .center)
                .navigationBarBackButtonHidden(true)
        } else if searchedDetail != nil {
            SummonerInfoView(mostChamp: mostChamp!, summoner: summonerInfo!, leagues: leagues, matchInfos: matchInfos, regionPicker: $regionPicker)

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
