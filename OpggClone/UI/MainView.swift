//
//  ContentView.swift
//  OpggClone
//
//  Created by Sy Lee on 2022/12/23.
//

import SwiftUI

struct MainView: View {
    @State var searchBarText: String = ""
    @State var goSearchView: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("LOGO")
                        .padding(.leading, 10)
                    Spacer()
                    // 위치선택 버튼
                    Button {
                        print("위치선택 버튼 클릭")
                    } label: {
                        Text("KR")
                    }
                    // 홈편집 버튼(네비게이션)
                    Button {
                        print("홈편집 버튼 클릭")
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.title)
                    }
                    Spacer()
                        .frame(width: 10)
                }
                //                NavigationLink {
                //                    SearchView(searchBarText: $searchBarText)
                //                } label: {
                //                    SearchBar(searchBarText: $searchBarText)
                //                        .padding(5)
                //                }
                SearchBar(searchBarText: $searchBarText)
                    .padding(5)
                    .onTapGesture {
                        goSearchView.toggle()
                    }
                
                    .navigationDestination(isPresented: $goSearchView) {
                        SearchView(searchBarText: $searchBarText)
                    }
                Spacer()
            }
        }
        
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MainView()
        }
    }
}
