//
//  ContentView.swift
//  OpggClone
//
//  Created by Sy Lee on 2022/12/23.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var mainVM = MainViewModel()
    
    @State var goSearchView: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Group {
                    SearchBar(searchBarText: $mainVM.searchBarText)
                        .padding(5)
                        .onTapGesture {
                            goSearchView.toggle()
                        }
                        .navigationDestination(isPresented: $goSearchView) {
                            SearchView(searchBarText: $mainVM.searchBarText)
                        }
                }
                Group {
                    Text("2022 AWARDS")
                        .font(.largeTitle)
                        .foregroundColor(.yellow)
                }
                Group {
                    MySummonerCard()
                        .padding(1)
                }
                
            } // List
            .listStyle(.grouped)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Picker("Kr", selection: $mainVM.regionPicker) {
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
        .edgesIgnoringSafeArea(.bottom)
    }
    
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MainView()
        }
    }
}
