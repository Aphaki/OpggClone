//
//  SummonerInfoView.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/01/11.
//

import SwiftUI

struct SummonerInfoView: View {
    
    var summoner: SummonerInfo
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomLeading) {
                //배경화면
                AsyncImage(url: URL(string: "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Aatrox_0.jpg")) { img in
                    img
                        .resizable()
                        .frame(width: .infinity, height: 250)
                } placeholder: {
                    Image(systemName: "questionmark.circle.fill")
                }
                AsyncImage(url: URL(string: "https://ddragon.leagueoflegends.com/cdn/13.1.1/img/profileicon/\(summoner.profileIconId).png")) { img in
                    img
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .leading)
                    
                } placeholder: {
                    Image(systemName: "person.circle")
                }
                
                
            }//ZStack
            Spacer()
        }
        .ignoresSafeArea()
    }
}


struct SummonerInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SummonerInfoView(summoner: myPreviewClass.summoner)
    }
}
