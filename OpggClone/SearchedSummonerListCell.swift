//
//  SearchedSummonerListCell.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/02/03.
//

import SwiftUI

struct SearchedSummonerListCell: View {
    
    let detailSummonerInfo: DetailSummonerInfo
    
    var icon: Int { return detailSummonerInfo.icon }
    var name: String { return detailSummonerInfo.summonerName }
    var tierImg: String { return detailSummonerInfo.tier }
    
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: "https://ddragon.leagueoflegends.com/cdn/13.1.1/img/profileicon/\(icon).png")) { img in
                img
                    .resizable()
                    .frame(width: 50, height: 50)
            } placeholder: {
                ProgressView()
            }
            VStack(alignment: .leading, spacing: 0) {
                Text(name)
                    .font(.headline)
                HStack {
                    Image(tierImg)
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("Unranked")
                }
                .font(.caption)
            }
            Spacer()
            HStack(spacing: 18) {
                Image(systemName: "star")
                    .resizable()
                    .frame(width: 27, height: 27)
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 27, height: 27)
            }
        }
    }
}

//struct SearchedSummonerListCell_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchedSummonerListCell()
//    }
//}
