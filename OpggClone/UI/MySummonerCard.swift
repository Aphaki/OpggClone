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
                }
            }
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 2).foregroundColor(.secondary))
        }
    }
}

struct MySummonerCard_Previews: PreviewProvider {
    static var previews: some View {
        MySummonerCard()
    }
}

struct ChampCell: View {
    
    var champName: String
    var winningRate: Int
    var kda: Double
    
    var body: some View {
        HStack {
            Image("Camille_0")
                .resizable()
                .clipShape(Circle())
                .frame(width: 40, height: 40)
            VStack {
                Text("\(winningRate)%")
                Text("\(kda):1")
            }.font(.caption)
        }
    }
}
