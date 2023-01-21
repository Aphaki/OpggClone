//
//  SearchView.swift
//  OpggClone
//
//  Created by Sy Lee on 2022/12/23.
//

import SwiftUI

struct SearchView: View {
    
    @EnvironmentObject var mainVM: MainViewModel
    
    @State var searchBarText: String = ""
    @State var goToSummonerInfoView: Bool = false
    
    var body: some View {
        VStack {
            SearchBar(searchBarText: $searchBarText, goToSummonerInfoView: $goToSummonerInfoView)
                .padding(5)
            Spacer()
        }
        .navigationDestination(isPresented: $goToSummonerInfoView) {
            SummonerInfoView(summoner: mainVM.summonerInfo ?? MyPreviewClass.shared.summoner, leagues: mainVM.leagueInfo, matchInfos: mainVM.matchInfos)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SearchView()
                .environmentObject(myPreviewClass.mainVM)
        }
    }
}
