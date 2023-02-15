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
    @Binding var searchedASummoner: DetailSummonerInfo?
    @Binding var regionPicker: UrlHeadPoint
    @State var selectedSummoner: DetailSummonerInfo?
    
    @State var searchBarText: String = ""
    @State var goToSummonerInfoView: Bool = false
    @State var goToSearchedSummonerInfoView: Bool = false
    
    var body: some View {
        VStack {
            SearchBar(searchedSummonersDetail: $searchedSummonersDetail, searchedASummoner: $searchedASummoner, regionPicker: $regionPicker, searchBarText: $searchBarText, goToSummonerInfoView: $goToSummonerInfoView)
                .padding(5)
            Divider()
            ForEach($searchedSummonersDetail) { aSummoner in
                SearchedSummonerListCell(detailSummonerInfo: aSummoner)
                    .onTapGesture {
                        self.selectedSummoner = aSummoner.wrappedValue
                        goToSearchedSummonerInfoView.toggle()
                    }
            }
            Spacer()
        }
        .navigationDestination(isPresented: $goToSummonerInfoView) {

            SummonerInfoLoadingView(searchedDetail: searchedASummoner, goToSummonerInfoView: $goToSummonerInfoView, regionPicker: $regionPicker)
        }
        .navigationDestination(isPresented: $goToSearchedSummonerInfoView) {
            SummonerInfoLoadingView(searchedDetail: selectedSummoner, goToSummonerInfoView: $goToSearchedSummonerInfoView, regionPicker: $regionPicker)
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
