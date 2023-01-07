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
    @State var regionPicker: UrlHeadPoint = .kr
    
    var body: some View {
        NavigationStack {
            List {
                SearchBar(searchBarText: $searchBarText)
                    .padding(5)
                    .onTapGesture {
                        goSearchView.toggle()
                    }
                
                    .navigationDestination(isPresented: $goSearchView) {
                        SearchView(searchBarText: $searchBarText)
                    }
                SearchedUserCell(starMarkOn: false)
            } // List
            .listStyle(.grouped)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Picker("Kr", selection: $regionPicker) {
                            Text("Kr").tag(UrlHeadPoint.kr)
                            Text("Br").tag(UrlHeadPoint.tr1)
                            Text("Jp").tag(UrlHeadPoint.jpOne)
                            Text("Ru").tag(UrlHeadPoint.ru)
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            print("홈편집 버튼 클릭")
                        } label: {
                            Image(systemName: "line.3.horizontal")
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("logo".uppercased())
                    }
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
