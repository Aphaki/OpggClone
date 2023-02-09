//
//  ContentView.swift
//  OpggClone
//
//  Created by Sy Lee on 2022/12/23.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var mainVM: MainViewModel
    
    @State var goSearchView: Bool = false
    @State var goToAddView: Bool = false
    @State var noSummonerAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                // 서치바
                SearchBarImageView()
                    .padding(10)
                    .onTapGesture {
                        goSearchView.toggle()
                    }
                    .navigationDestination(isPresented: $goSearchView) {
                        SearchView(searchedSummonersDetail: $mainVM.searchedSummonersDetail)
                    }
                    .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.myColor.backgroundColor))
                // 내 소환사 카드
                VStack {
                    if mainVM.isLoading == false {
                        MySummonerCard(mySummonerInfo: $mainVM.myDetailSummonerInfo, goToAddView: $goToAddView)
                    } else {
                        ProgressView()
                    }
                }
               
                // 북마크(즐겨찾기) 소환사들
                if !mainVM.bookMarkSummonersDetail.isEmpty {
                    Divider()
                    VStack {
                        Text("즐겨찾기한 소환사")
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(mainVM.bookMarkSummonersDetail) { aDetail in
                                    BookmarkSummonerCard(detailSummonerInfo: aDetail)
                                }
                            }
                        }
                    }
                }
                Spacer()
            }
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
                        ZStack(alignment: .trailing) {
                            Image(systemName: "line.3.horizontal")
                                .foregroundColor(.white)
                            Image(systemName: "arrow.down")
                                .resizable()
                                .frame(width: 10, height: 15)
                                .foregroundColor(.white)
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("logo".uppercased())
                        .font(.largeTitle)
                        .foregroundColor(Color.myColor.darkBlue)
                }
            }
            .navigationDestination(isPresented: $goToAddView) {
                MySummonerAddView(goToAddView: $goToAddView)
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .edgesIgnoringSafeArea(.bottom)
        .alert("없는 소환사입니다.", isPresented: $noSummonerAlert) {
            Button {
                mainVM.isLoading = false
            } label: {
                Text("OK")
            }
        }
        .onReceive(mainVM.noSummonerError) { _ in
            noSummonerAlert.toggle()
        }
        
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MainView()
                .environmentObject(myPreviewClass.mainVM)
                .background(Color.myColor.appBG)
                .preferredColorScheme(.dark)
        }
    }
}
