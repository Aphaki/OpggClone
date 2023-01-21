//
//  SummonerInfoView.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/01/11.
//

import SwiftUI

struct SummonerInfoView: View {
    
    var summoner: SummonerInfo
    var leagues: [SummonersLeagueElement]
    var matchInfos: [MatchInfo]
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                ZStack(alignment: .bottomLeading) {
                    //배경화면
                    AsyncImage(url: URL(string: "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Aatrox_0.jpg")) { img in
                        img
                            .resizable()
                            .frame(width: .infinity, height: geo.size.height / 4)
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
                    .frame(maxWidth: .infinity)
                    .padding(5)
                    .background(RoundedRectangle(cornerRadius: 5).foregroundColor(Color.myColor.myBlack))
                HStack {
                    Button {
                        
                    } label: {
                        Text("전적 갱신")
                            .foregroundColor(.white)
                            .frame(maxWidth: geo.size.width / 2)
                            .padding(.vertical, 10)
                            .background(RoundedRectangle(cornerRadius: 5).foregroundColor(Color.myColor.myDarkBlue))
                    }
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("인게임")
                            .foregroundColor(.white)
                        
                            .frame(maxWidth: geo.size.width / 2)
                            .padding(.vertical, 10)
                            .background(RoundedRectangle(cornerRadius: 5).foregroundColor(.gray))
                    }
                }
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(leagues) { league in
                            HStack {
                                Image(league.tier.lowercased())
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(league.queueType)
                                        .foregroundColor(.white)
                                        .padding(3)
                                        .background(RoundedRectangle(cornerRadius: 5).foregroundColor(Color.myColor.mylightBlue))
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
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1))
                        }
                    }
                } //Scroll View
                VStack {
                    ForEach(matchInfos) { info in
                        MatchListCell(matchInfo: info, summoner: summoner)
                            .frame(maxWidth: .infinity)
                    }
                }
                Spacer()
            }
            .ignoresSafeArea()
        }
    }
}


struct SummonerInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SummonerInfoView(summoner: myPreviewClass.summoner, leagues: myPreviewClass.leagues, matchInfos: myPreviewClass.matchInfos)
            .preferredColorScheme(.dark)
    }
}

extension SummonerInfoView {
    
    var icon: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: URL(string: "https://ddragon.leagueoflegends.com/cdn/13.1.1/img/profileicon/\(summoner.profileIconId).png")) { img in
                img
                    .resizable()
                    .frame(width: 80, height: 80, alignment: .leading)
            } placeholder: {
                Image(systemName: "person.circle")
            }
            .clipShape(Circle())
            Text("\(summoner.summonerLevel)")
                .font(.caption)
                .foregroundColor(.white)
                .padding(2)
                .background(RoundedRectangle(cornerRadius: 20).foregroundColor(Color.myColor.myBlack))
        }
    }
    var nameAndRanking: some View {
        VStack(alignment: .leading) {
            Text(summoner.name)
                .font(.title)
                .foregroundColor(.white)
            Text("래더 랭킹 -")
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}
