//
//  SearchBar.swift
//  OpggClone
//
//  Created by Sy Lee on 2022/12/23.
//

import SwiftUI

struct SearchBar: View {
    
    @EnvironmentObject var mainVM: MainViewModel
    
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
                    // vm.서버에 리퀘스트 (searchBarText로)
                    print("search 버튼 클릭")
                    goToSummonerInfoView.toggle()
                    mainVM.searchBarText = searchBarText
                    mainVM.totalRequest()
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

struct SearchBar_Previews: PreviewProvider {
    
    static var previews: some View {
        SearchBar(searchBarText: .constant(""), goToSummonerInfoView: .constant(false))
            .environmentObject(myPreviewClass.mainVM)
    }
}
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
                .foregroundColor(.secondary)
        )
    }
}

