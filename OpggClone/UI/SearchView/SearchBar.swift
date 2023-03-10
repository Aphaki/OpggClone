//
//  SearchBar.swift
//  OpggClone
//
//  Created by Sy Lee on 2022/12/23.
//

import SwiftUI

struct SearchBar: View {
    
    @EnvironmentObject var mainVM: MainViewModel

    @Binding var searchedSummonersDetail: [DetailSummonerInfo]
    @Binding var searchedASummoner: DetailSummonerInfo?
    @Binding var regionPicker: UrlHeadPoint
    
    @Binding var searchBarText: String
    @Binding var goToSummonerInfoView: Bool
    
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .padding(.leading, 5)
            TextField("소환사 검색", text: $searchBarText)
                .font(.headline)
                .padding(.vertical, 10)
                .onSubmit {
                    Task {
                        goToSummonerInfoView.toggle()
//                       try await mainVM.saveSearchedDetail(urlBase: mainVM.regionPicker ,name: searchBarText)
//                        if mainVM.searchedDetail != nil {
//                            mainVM.duplicateCheckAndAdd(aDetailSummoner: mainVM.searchedDetail!)
//                        }
                        self.searchedASummoner = try await mainVM.fetchAndChangedToDetail(urlBase: regionPicker, name: searchBarText)
                        if searchedASummoner != nil {
                            mainVM.duplicateCheckAndAdd(aDetailSummoner: searchedASummoner!, summonerList: &searchedSummonersDetail)
                        }
                        
                    }
                    
                }
                .submitLabel(.search)
            if !searchBarText.isEmpty {
                Image(systemName: "xmark")
                    .padding(15)
                    .onTapGesture {
                        searchBarText = ""
                    }
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 5)
                .stroke(lineWidth: 2)
                .foregroundColor(.secondary)
        )
    }
}

//struct SearchBar_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        SearchBar(searchBarText: .constant(""), goToSummonerInfoView: .constant(false))
//            .environmentObject(myPreviewClass.mainVM)
//    }
//}

struct SearchBarImageView: View {
    
    @State var text = ""
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .padding(.leading, 5)
            TextField("소환사 검색", text: $text)
                .font(.headline)
                .padding(.vertical, 10)
        }
        .background(
            RoundedRectangle(cornerRadius: 5)
                .stroke(lineWidth: 2)
        )
    }
}

