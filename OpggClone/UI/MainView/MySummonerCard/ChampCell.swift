//
//  ChampCell.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/02/01.
//

import SwiftUI

struct ChampCell: View {
    
    var champName: String
    var winningRate: Int
    var kda: Double
    
    var body: some View {
        if champName != "" {
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
                            kda > 5 ? .red : kda > 3 ? .green : .gray
                        )
                }.font(.headline)
            }
        } else {
            HStack {
                Image("7050")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            VStack(alignment: .leading) {
                Text("\(winningRate)%")
                Text("none")
            }.font(.headline)
        }
        
    }
}
