//
//  SummonerInfoView.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/01/11.
//

import SwiftUI

struct SummonerInfoView: View {
    
    @EnvironmentObject var mainVM: MainViewModel
    @Environment(\.dismiss) var dismiss
    @StateObject var vm: SearchInfoViewModel
    @State var ingameAlert: Bool = false
    
    init(mostChamp: String, summoner: SummonerInfo, leagues: [SummonersLeagueElement], matchInfos: [MatchInfo], regionPicker: Binding<UrlHeadPoint>) {
        _vm = StateObject(wrappedValue: SearchInfoViewModel(mostChamp: mostChamp, summoner: summoner, leagues: leagues, matchInfos: matchInfos, regionPicker: regionPicker.wrappedValue) )
    }
    
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                ScrollView {
                    VStack {
                        ZStack(alignment: .bottomLeading) {
                            //배경화면
                            AsyncImage(url: vm.mostChamp.toBackgroundChampImgURL()) { img in
                                img
                                    .resizable()
                                    .frame(width: geo.size.width, height: geo.size.height / 4)
                            } placeholder: {
                                Image(systemName: "questionmark.circle.fill")
                            }
                            HStack {
                                icon
                                    .padding(.vertical, 10)
                                    .padding(.leading, 10)
                                nameAndRanking
                            }
                        }
                        //ZStack
                        Text("라이엇 계정을 연동하고 나만의 프로필을 설정해보세요!")
                            .font(.caption)
                            .foregroundColor(Color.myColor.accentColor)
                            .frame(maxWidth: .infinity)
                            .padding(5)
                            .background(RoundedRectangle(cornerRadius: 5).foregroundColor(Color.myColor.backgroundColor))
                        HStack {
                            Button {
                                
                            } label: {
                                Text("전적 갱신")
                                    .foregroundColor(.white)
                                    .frame(maxWidth: geo.size.width / 2)
                                    .padding(.vertical, 10)
                                    .background(RoundedRectangle(cornerRadius: 5).foregroundColor(Color.myColor.darkBlue))
                            }
                            Spacer()
                            Button {
                                vm.clickInGameInfo(urlBaseHead: vm.regionPicker, encryptedSummonerId: vm.summoner.id)
                            } label: {
                                Text("인게임")
                                    .foregroundColor(.white)
                                    .frame(maxWidth: geo.size.width / 2)
                                    .padding(.vertical, 10)
                                    .background(RoundedRectangle(cornerRadius: 5).foregroundColor(Color.myColor.gray))
                            }
                        }
                        .navigationDestination(isPresented: $vm.goInGameView, destination: {
                            IngameMatchInfoLoadingView(spectator: $vm.spectator)
                        })
                        .alert("현재 게임중이 아닙니다.", isPresented: $ingameAlert) {
                            Button {
                                vm.inGameLoading = false
                            } label: {
                                Text("OK")
                            }
                        }
                        .onReceive(vm.noIngameError) { _ in
                            self.ingameAlert.toggle()
                        }
                        
                        ScrollView(.horizontal) {
                            HStack {
                                if !vm.leagues.isEmpty {
                                    ForEach(vm.leagues) { league in
                                        HStack {
                                            Image(league.tier.lowercased())
                                                .resizable()
                                                .frame(width: 100, height: 100)
                                            VStack(alignment: .leading, spacing: 5) {
                                                Text(vm.queueTypeDic[league.queueType] ?? "기타")
                                                    .foregroundColor(.white)
                                                    .padding(3)
                                                    .background(RoundedRectangle(cornerRadius: 5).foregroundColor(Color.myColor.lightBlue))
                                                Text(league.tier + " " + league.rank)
                                                    .font(.headline)
                                                Text("\(league.leaguePoints)" + " LP")
                                                    .font(.caption)
                                                    .foregroundColor(.gray)
                                                Text("\(league.wins)승 \(league.losses)패  \(league.winRates)%")
                                                    .font(.caption)
                                                    .foregroundColor(.gray)
                                            }
                                            Image(systemName: "chevron.forward")
                                        }
                                        .frame(width: 270)
                                        .padding(10)
                                        .background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1))
                                    }
                                } else {
                                    HStack {
                                        Image("provisional")
                                            .resizable()
                                            .frame(width: 100, height: 100)
                                        VStack(alignment: .leading, spacing: 5) {
                                            Text(vm.queueTypeDic["RANKED_SOLO_5x5"] ?? "기타")
                                                .foregroundColor(.white)
                                                .padding(3)
                                                .background(RoundedRectangle(cornerRadius: 5).foregroundColor(Color.myColor.lightBlue))
                                            Text("Unranked")
                                                .font(.headline)
                                            Text("0" + " LP")
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                            Text("0승 0패  0%")
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                        }
                                        Image(systemName: "chevron.forward")
                                    }
                                    .frame(width: 240)
                                    .padding(10)
                                    .background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1))
                                    HStack {
                                        Image("provisional")
                                            .resizable()
                                            .frame(width: 100, height: 100)
                                        VStack(alignment: .leading, spacing: 5) {
                                            Text(vm.queueTypeDic["RANKED_FLEX_SR"] ?? "기타")
                                                .foregroundColor(.white)
                                                .padding(3)
                                                .background(RoundedRectangle(cornerRadius: 5).foregroundColor(Color.myColor.lightBlue))
                                            Text("Unranked")
                                                .font(.headline)
                                            Text("0" + " LP")
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                            Text("0승 0패  0%")
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                        }
                                        Image(systemName: "chevron.forward")
                                    }
                                    .frame(width: 240)
                                    .padding(10)
                                    .background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1))
                                }
                                
                            }
                        } //Scroll View
                        
                        VStack(spacing:0) {
                            ForEach(vm.matchInfos) { info in
                                Divider()
                                NavigationLink {
                                    MatchDetailView(matchInfo: info, summonerInfo: vm.summoner)
                                } label: {
                                    MatchListCell(matchInfo: info, summoner: vm.summoner)
                                        .frame(maxWidth: .infinity)
                                }
                            }
                            if !vm.addLoading {
                                Text("더 보기")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.myColor.secondary)
                                    .onTapGesture {
                                        vm.matchIndex += 5
                                        vm.addAdditionalInfo(start: vm.matchIndex, count: vm.AddInfoCount)
                                    }
                            } else {
                                ProgressView()
                            }
                        }
                        Spacer()
                    }
                }
                .ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                            mainVM.searchedDetail = nil
                        } label: {
                            Image(systemName: "chevron.left")
                        }

                    }
                }
                if vm.inGameLoading == true {
                    ZStack {
                        Color.myColor.backgroundColor.ignoresSafeArea()
                            .opacity(0.3)
                        ProgressView()
                    }
                }
            } // ZStack
            
        }
    }
}


//struct SummonerInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        SummonerInfoView(summoner: myPreviewClass.summoner, leagues: myPreviewClass.leagues, matchInfos: myPreviewClass.matchInfos)
//            .preferredColorScheme(.dark)
//    }
//}

extension SummonerInfoView {
    
    var icon: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: vm.summoner.profileIconId.toIconImgURL()) { img in
                img
                    .resizable()
                    .frame(width: 80, height: 80, alignment: .leading)
            } placeholder: {
                Image(systemName: "person.circle")
            }
            .clipShape(Circle())
            Text("\(vm.summoner.summonerLevel)")
                .font(.caption)
                .foregroundColor(.white)
                .padding(2)
                .background(RoundedRectangle(cornerRadius: 20).foregroundColor(Color.myColor.black))
        }
    }
    var nameAndRanking: some View {
        VStack(alignment: .leading) {
            Text(vm.summoner.name)
                .font(.title)
                .foregroundColor(.white)
            Text("래더 랭킹 -")
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}
