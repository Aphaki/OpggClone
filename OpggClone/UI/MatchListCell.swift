//
//  MatchListCell.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/01/12.
//

import SwiftUI

struct MatchListCell: View {
    
    var matchInfo: MatchInfo
    var participant: Participant
    let spellDictionary = InstanceOfSummonerSpell.instance.spellDictionary
    
    
    var body: some View {
        HStack {
            // 승 - 패 - 시간
            VStack {
                Text(participant.win == true ? "승" : "패")
                Divider()
                Text("42:38")
            }
            .font(.caption)
            .frame(maxWidth: 40, maxHeight: 100)
            .background(participant.win == true ? Color.myColor.mylightBlue : Color.myColor.myRed)
            .foregroundColor(.white)
            
            // 세부 정보
            VStack {
                HStack {
                    HStack(spacing: 3) {
                        AsyncImage(url: URL(string: "https://ddragon.leagueoflegends.com/cdn/13.1.1/img/champion/\(participant.championName).png")) { img in
                            img
                                .resizable()
                                .frame(width: 60, height: 60)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        } placeholder: {
                            ProgressView()
                        }
                        VStack(spacing: 2) {
                            AsyncImage(url: URL(string: "https://ddragon.leagueoflegends.com/cdn/13.1.1/img/spell/\(spellDictionary["1"] ?? "SummonerTeleport").png")) { img in
                                img
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .clipShape(RoundedRectangle(cornerRadius: 7))
                            } placeholder: {
                                ProgressView()
                            }
                            AsyncImage(url: URL(string: "https://ddragon.leagueoflegends.com/cdn/13.1.1/img/spell/\(spellDictionary["2"] ?? "SummonerFlash").png")) { img in
                                img
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .clipShape(RoundedRectangle(cornerRadius: 7))
                            } placeholder: {
                                ProgressView()
                            }
                        }
                        VStack(spacing: 2) {
                            Image("GraspOfTheUndying")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .clipShape(RoundedRectangle(cornerRadius: 7))
                            Image("7202_Sorcery")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .clipShape(RoundedRectangle(cornerRadius: 7))
                        }
                        VStack(alignment: .leading, spacing: 2) {
                            HStack(spacing: 3) {
                                Text("\(participant.kills)")
                                Text("/")
                                Text("\(participant.deaths)")
                                    .foregroundColor(Color.myColor.myRed)
                                Text("/")
                                Text("\(participant.assists)")
    //                            Text("  \(participant.kda.with2Demicals()):1")
    //                                .foregroundColor(participant.kda > 6 ? .red : participant.kda > 4 ? .blue : participant.kda > 3 ? .green : .gray)
                                
                            }.font(.body)
                            Text("킬 관여 63%")
                                .font(.caption)
                                .foregroundColor(Color.myColor.myGray)
                        }
                        Spacer()
                        VStack {
                            Text("개인/2인 랭크")
                                .font(.caption)
                                .foregroundColor(Color.myColor.myGray)
                        }
                    }
                }
                .frame(height: 70)
                HStack(spacing: 2) {
                    
                    ItemImage(itemNumber: participant.item0)
                    ItemImage(itemNumber: participant.item1)
                    ItemImage(itemNumber: participant.item2)
                    ItemImage(itemNumber: participant.item3)
                    ItemImage(itemNumber: participant.item4)
                    ItemImage(itemNumber: participant.item5)
                    ItemImage(itemNumber: participant.item6)
                    Spacer()
                    Text(participant.pentaKills > 0 ? "펜타킬" : participant.quadraKills > 0 ? "쿼드라킬" : participant.tripleKills > 0 ? "트리플킬" : participant.doubleKills > 0 ? "더블킬" : "")
                        .font(.caption)
                        .foregroundColor(Color.myColor.myRed)
                        .padding(2)
                        .background(RoundedRectangle(cornerRadius: 3).foregroundColor(Color.myColor.myRed.opacity(0.2)))
                }
                .frame(height: 30)
            }
            
           
        }
    }
}

struct MatchListCell_Previews: PreviewProvider {
    static var previews: some View {
        MatchListCell(matchInfo: myPreviewClass.matchInfo, participant: myPreviewClass.aSummonerInfo)
            .preferredColorScheme(.dark)
    }
}

struct ItemImage: View {

    var itemNumber: Int
    
    var body: some View {
        if itemNumber != 0 {
            Image(itemNumber.description)
                .resizable()
                .frame(width: 25, height: 25)
                .clipShape(RoundedRectangle(cornerRadius: 7))
                .overlay {
                    RoundedRectangle(cornerRadius: 7).stroke(lineWidth: 3).foregroundColor(itemNumber >= 6630 ? .yellow : .clear)
                }
        } else {
            Image("7050")
                .resizable()
                .frame(width: 25, height: 25)
                .clipShape(RoundedRectangle(cornerRadius: 7))
        }
        
    }
}
