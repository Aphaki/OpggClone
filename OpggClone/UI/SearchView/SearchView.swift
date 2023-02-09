//
//  SearchView.swift
//  OpggClone
//
//  Created by Sy Lee on 2022/12/23.
//

import SwiftUI

struct SearchView: View {
    
    @EnvironmentObject var mainVM: MainViewModel
    
    @Binding var searchedSummonersDetail: [DetailSummonerInfo]

    
    @State var searchBarText: String = ""
    @State var goToSummonerInfoView: Bool = false
    
    var body: some View {
        VStack {
            SearchBar(searchBarText: $searchBarText, goToSummonerInfoView: $goToSummonerInfoView)
                .padding(5)
            Divider()
            ForEach($searchedSummonersDetail) { aSummoner in
                SearchedSummonerListCell(detailSummonerInfo: aSummoner)
            }
            Spacer()
        }
        .navigationDestination(isPresented: $goToSummonerInfoView) {

            SummonerInfoLoadingView(searchedDetail: mainVM.searchedDetail, goToSummonerInfoView: $goToSummonerInfoView)
        }
    }
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            SearchView()
//                .environmentObject(myPreviewClass.mainVM)
//        }
//    }
//}
