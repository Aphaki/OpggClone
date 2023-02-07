//
//  BookmarkSummonerCard.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/02/07.
//

import SwiftUI

struct BookmarkSummonerCard: View {
    
    let detailSummonerInfo: DetailSummonerInfo
    
    var body: some View {
        VStack(spacing: 10) {
            // 아이콘 이미지 + 레벨
            ZStack(alignment: .bottom) {
                AsyncImage(url: URL(string: "https://ddragon.leagueoflegends.com/cdn/13.1.1/img/profileicon/\(detailSummonerInfo.icon).png")) { img in
                    img
                        .resizable()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView()
                }
                Text(detailSummonerInfo.level.description)
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(2)
                    .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.myColor.gray))
            }
            // 아이디 + 티어
            VStack(spacing: 0) {
                Text(detailSummonerInfo.summonerName)
                    .font(.headline)
                    .foregroundColor(Color.myColor.accentColor)
                HStack(spacing: 3) {
                    Image(detailSummonerInfo.tier.lowercased())
                        .resizable()
                        .frame(width: 20, height: 20)
                    HStack(spacing: 1) {
                        Text(detailSummonerInfo.tier.description.uppercased() == "PROVISIONAL" ? "Unranked" : detailSummonerInfo.tier.description.uppercased() )
                        Text(detailSummonerInfo.rank.description)
                    }
                    .font(.caption)
                    .foregroundColor(Color.myColor.gray)
                    
                }
            }
        }
        .padding(10)
        .frame(width: 140, height: 150)
        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.myColor.secondary))
        
        

    }
}

//struct BookmarkSummonerCard_Previews: PreviewProvider {
//    static var previews: some View {
//        BookmarkSummonerCard()
//    }
//}
