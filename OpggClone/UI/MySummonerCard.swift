//
//  MySummonerCard.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/01/06.
//

import SwiftUI

struct MySummonerCard: View {
    var body: some View {
        VStack {
            SearchedUserCell(starMarkOn: false)
            VStack {
                Text("13승 7패 65% KDA 3.69:1")
                HStack {
                    ChampCell(champName: "Camille_0", winningRate: 75, kda: 5.67)
                    ChampCell(champName: "Akali_0", winningRate: 100, kda: 4.25)
                    ChampCell(champName: "Ezreal_0", winningRate: 50, kda: 10.67)
                }
            }
            .frame(maxWidth: .infinity, minHeight: 120)
            .background(RoundedRectangle(cornerRadius: 5).foregroundColor(.gray))
            Button {
                print("자세히 보기 버튼 클릭")
            } label: {
                Text("자세히 보기")
                    .foregroundColor(.white)
                    .padding(10)
                    .frame(maxWidth: .infinity, minHeight: 55)
                    .background(RoundedRectangle(cornerRadius: 5))
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
            Image(champName)
                .resizable()
                .clipShape(Circle())
                .frame(width: 55, height: 55)
            VStack(alignment: .leading) {
                Text("\(winningRate)%")
                Text("\(kda.with2Demicals()):1")
                    .foregroundColor(
                        kda > 5 ? .red : kda > 3 ? .green : .black
                    )
            }.font(.caption)
        }
    }
}


