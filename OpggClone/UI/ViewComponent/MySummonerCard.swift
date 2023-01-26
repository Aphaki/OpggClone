//
//  MySummonerCard.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/01/06.
//

import SwiftUI

struct MySummonerCard: View {
    var body: some View {
        GeometryReader { geo in
            VStack {
                SearchedUserCell(starMarkOn: false)
                VStack {
                    Text("13승 7패 65% KDA 3.69:1")
                    HStack(spacing: 0) {
                        ChampCell(champName: "Lux", winningRate: 75, kda: 5.67)
                            .frame(width: geo.size.width/3)
                        ChampCell(champName: "Mordekaiser", winningRate: 100, kda: 4.25)
                            .frame(width: geo.size.width/3)
                        ChampCell(champName: "Ezreal", winningRate: 50, kda: 10.67)
                            .frame(width: geo.size.width/3)
                    }
                }
                .frame(maxWidth: .infinity, minHeight: 120)
                .background(RoundedRectangle(cornerRadius: 5).foregroundColor(Color.myColor.secondary))
                Button {
                    print("자세히 보기 버튼 클릭")
                } label: {
                    Text("자세히 보기")
                        .foregroundColor(.white)
                        .padding(10)
                        .frame(maxWidth: .infinity, minHeight: 55)
                        .background(RoundedRectangle(cornerRadius: 5).foregroundColor(Color.myColor.darkBlue))
                }

            }
        }
       
    }
}

struct MySummonerCard_Previews: PreviewProvider {
    static var previews: some View {
        MySummonerCard()
            .preferredColorScheme(.dark)
    }
}

struct ChampCell: View {
    
    var champName: String
    var winningRate: Int
    var kda: Double
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: "https://ddragon.leagueoflegends.com/cdn/13.1.1/img/champion/\(champName).png")) { img in
                img
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            } placeholder: {
                ProgressView()
            }
            VStack(alignment: .leading) {
                Text("\(winningRate)%")
                Text("\(kda.with2Demicals()):1")
                    .foregroundColor(
                        kda > 5 ? .red : kda > 3 ? .green : .black
                    )
            }.font(.headline)
        }
    }
}


