//
//  SearchedSummonerListCell.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/02/03.
//

import SwiftUI

struct SearchedSummonerListCell: View {
    
    @EnvironmentObject var mainVM: MainViewModel
    
    @State var detailSummonerInfo: DetailSummonerInfo
    
    var icon: Int { return detailSummonerInfo.icon }
    var name: String { return detailSummonerInfo.summonerName }
    var tierImg: String { return detailSummonerInfo.tier }
    var isBookMark: Bool { return detailSummonerInfo.isBookMark }
    
    
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
                Button {
                    print("BookMark(별) 버튼 클릭")
                    self.detailSummonerInfo.isBookMark.toggle()
                } label: {
                    if isBookMark == true {
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 27, height: 27)
                            .foregroundColor(Color.myColor.darkBlue)
                    } else {
                        Image(systemName: "star")
                            .resizable()
                            .frame(width: 27, height: 27)
                            .foregroundColor(Color.myColor.secondary)
                    }
                    
                }
                Button {
                    print("SearchedUserCell - Xmark 클릭")
                    mainVM.searchedSummonersDetail.removeAll { aDetail in
                        return aDetail.summonerName == detailSummonerInfo.summonerName
                    }
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 27, height: 27)
                        .foregroundColor(Color.myColor.secondary)
                }

                
            }
        }
    }
}

//struct SearchedSummonerListCell_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchedSummonerListCell()
//    }
//}
