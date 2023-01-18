//
//  MatchDetailCell.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/01/18.
//

import SwiftUI

struct MatchDetailCell: View {
    
    var participant: Participant
    
    let spellDictionary = JsonInstance.shared.spellStore
    let primaryRuneDic = JsonInstance.shared.primaryRuneDic
    let detatilRuneDic = JsonInstance.shared.detailRuneDic
    
    var body: some View {
        HStack(spacing: 2) {
            // 챔프
            ZStack(alignment: .bottomTrailing) {
                AsyncImage(url: URL(string: "https://ddragon.leagueoflegends.com/cdn/13.1.1/img/champion/\(participant.championName).png")) { img in
                    img
                        .resizable()
                        .frame(width: 42, height: 42)
                        .clipShape(RoundedRectangle(cornerRadius: 11))
                } placeholder: {
                    ProgressView()
                }
                Text("\(participant.champLevel)")
                    .font(.caption)
                    .foregroundColor(.white)
                    .background(RoundedRectangle(cornerRadius: 5).foregroundColor(Color.myColor.myGray))
            }
            //스펠
            VStack(spacing: 2) {
                AsyncImage(url: URL(string: "https://ddragon.leagueoflegends.com/cdn/13.1.1/img/spell/\(spellDictionary[participant.summoner1ID.formatted()]!).png")) { img in
                    img
                        .resizable()
                        .frame(width: 20, height: 20)
                        .clipShape(RoundedRectangle(cornerRadius: 3))
                } placeholder: {
                    ProgressView()
                }
                AsyncImage(url: URL(string: "https://ddragon.leagueoflegends.com/cdn/13.1.1/img/spell/\(spellDictionary[participant.summoner2ID.formatted()]!).png")) { img in
                    img
                        .resizable()
                        .frame(width: 20, height: 20)
                        .clipShape(RoundedRectangle(cornerRadius: 3))
                } placeholder: {
                    ProgressView()
                }
            }
            //룬
            VStack(spacing: 2) {
                Image((detatilRuneDic[participant.perks.styles.first!.selections.first!.perk] ?? ""))
                    .resizable()
                    .frame(width: 20, height: 20)
                    .clipShape(RoundedRectangle(cornerRadius: 3))
                AsyncImage(url: URL(string: "https://ddragon.leagueoflegends.com/cdn/img/" + (primaryRuneDic[participant.perks.styles[1].style] ?? ""))) { img in
                    img
                        .resizable()
                        .frame(width: 20, height: 20)
                        .clipShape(RoundedRectangle(cornerRadius: 3))
                } placeholder: {
                    ProgressView()
                }
            }
            VStack(alignment: .leading) {
                Text(participant.summonerName)
                HStack(spacing: 5) {
                    Text(" \(participant.kills)")
                    Text("/")
                    Text("\(participant.deaths)")
                        .foregroundColor(Color.myColor.myRed)
                    Text("/")
                    Text("\(participant.assists)")
                    Text("")
                    Text("\(participant.kda.with2Demicals()):1")
                        .foregroundColor(participant.kda > 6 ? .red : participant.kda > 4 ? .blue : participant.kda > 3 ? .green : .gray)
                    
                }.font(.caption)
            }
            Spacer()
            VStack(alignment: .leading) {
                HStack(spacing: 1) {
                    ItemImage(itemNumber: participant.item0, width: 20, height: 20)
                    ItemImage(itemNumber: participant.item1, width: 20, height: 20)
                    ItemImage(itemNumber: participant.item2, width: 20, height: 20)
                    ItemImage(itemNumber: participant.item3, width: 20, height: 20)
                    ItemImage(itemNumber: participant.item4, width: 20, height: 20)
                    ItemImage(itemNumber: participant.item5, width: 20, height: 20)
                    ItemImage(itemNumber: participant.item6, width: 20, height: 20)
                }
                HStack(spacing: 2) {
                    Text("19(0.5) / \(participant.goldEarned.withKString())")
                        .font(.caption)
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 50, height: 15)
                            .foregroundColor(Color.myColor.myRed)
                        Text(participant.totalDamageDealtToChampions.withKString())
                            .font(.caption)
                    }
                }
            }
            .frame(width: 150)
        }
    }
}

struct MatchDetailCell_Previews: PreviewProvider {
    static var previews: some View {
        MatchDetailCell(participant: myPreviewClass.aSummonerInfo)
            .preferredColorScheme(.dark)
    }
}
