//
//  MatchListCell.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/01/12.
//

import SwiftUI

struct MatchListCell: View {
    
    var matchInfo: MatchInfo
    var summoner: SummonerInfo
    var participant: Participant {
        let value =
        matchInfo.info.participants.first { aParticipant in
           return aParticipant.puuid == summoner.puuid
        }
        return value!
    }
    var mythicItem: Int {
        let value =  participant.challenges["mythicItemUsed"]
        let valueInt = Int(value ?? 0.0)
        return valueInt
    }
    
    let spellDictionary = JsonInstance.shared.spellStore
    let primaryRuneDic = JsonInstance.shared.primaryRuneDic
    let detatilRuneDic = JsonInstance.shared.detailRuneDic
    let queueTypeDic = JsonInstance.shared.queueType
    
    
    var body: some View {
        HStack {
            // 승 - 패 - 시간
            VStack {
                Text(participant.win == true ? "승" : "패")
                Divider()
                Text("\(matchInfo.info.gameDuration / 60):\(matchInfo.info.gameDuration % 60)")
            }
            .font(.caption)
            .frame(maxWidth: 40, maxHeight: 120)
            .background(participant.win == true ? Color.myColor.lightBlue : Color.myColor.red)
            .foregroundColor(.white)
            
            // 세부 정보
            VStack(spacing: 0) {
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
                            AsyncImage(url: URL(string: "https://ddragon.leagueoflegends.com/cdn/13.1.1/img/spell/\(spellDictionary[participant.summoner1ID.formatted()]!).png")) { img in
                                img
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .clipShape(RoundedRectangle(cornerRadius: 7))
                            } placeholder: {
                                ProgressView()
                            }
                            AsyncImage(url: URL(string: "https://ddragon.leagueoflegends.com/cdn/13.1.1/img/spell/\(spellDictionary[participant.summoner2ID.formatted()]!).png")) { img in
                                img
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .clipShape(RoundedRectangle(cornerRadius: 7))
                            } placeholder: {
                                ProgressView()
                            }
                        }
                        VStack(spacing: 2) {
                            
                            AsyncImage(url: URL(string:  "https://ddragon.leagueoflegends.com/cdn/img/" + (detatilRuneDic[participant.perks.styles[0].selections[0].perk] ?? ""))) { img in
                                img
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .clipShape(RoundedRectangle(cornerRadius: 7))
                            } placeholder: {
                                ProgressView()
                            }

//                            Image((detatilRuneDic[participant.perks.styles.first!.selections.first!.perk] ?? ""))
//                                .resizable()
//                                .frame(width: 25, height: 25)
//                                .clipShape(RoundedRectangle(cornerRadius: 7))
                            AsyncImage(url: URL(string: "https://ddragon.leagueoflegends.com/cdn/img/" + (primaryRuneDic[participant.perks.styles[1].style] ?? ""))) { img in
                                img
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .clipShape(RoundedRectangle(cornerRadius: 7))
                            } placeholder: {
                                ProgressView()
                            }
                                
                        }
                        VStack(alignment: .leading, spacing: 2) {
                            HStack(spacing: 5) {
                                Text(" \(participant.kills)")
                                Text("/")
                                Text("\(participant.deaths)")
                                    .foregroundColor(Color.myColor.red)
                                Text("/")
                                Text("\(participant.assists)")
    //                            Text("  \(participant.kda.with2Demicals()):1")
    //                                .foregroundColor(participant.kda > 6 ? .red : participant.kda > 4 ? .blue : participant.kda > 3 ? .green : .gray)
                                
                            }.font(.title)
                            Text("  킬 관여 \(participant.challenges["killParticipation"]?.changedPercentage() ?? "0" )%")
                                .font(.caption)
                                .foregroundColor(Color.myColor.gray)
                        }
                        Spacer()
                        VStack {
                            Text(queueTypeDic[matchInfo.info.queueID.description] ?? "기타")
                                .font(.caption)
                                .foregroundColor(Color.myColor.gray)
//                            Text((detatilRuneDic[participant.perks.styles.first!.selections.first!.perk] ?? ""))
                        }
                    }
                }
                .frame(height: 75)
                HStack(spacing: 2) {
                    
                    ItemImage(itemNumber: participant.item0, width: 25, height: 25, mythicItemInt: mythicItem)
                    ItemImage(itemNumber: participant.item1, width: 25, height: 25, mythicItemInt: mythicItem)
                    ItemImage(itemNumber: participant.item2, width: 25, height: 25, mythicItemInt: mythicItem)
                    ItemImage(itemNumber: participant.item3, width: 25, height: 25, mythicItemInt: mythicItem)
                    ItemImage(itemNumber: participant.item4, width: 25, height: 25, mythicItemInt: mythicItem)
                    ItemImage(itemNumber: participant.item5, width: 25, height: 25, mythicItemInt: mythicItem)
                    ItemImage(itemNumber: participant.item6, width: 25, height: 25, mythicItemInt: mythicItem)
                    Spacer()
                    Text(participant.pentaKills > 0 ? "펜타킬" : participant.quadraKills > 0 ? "쿼드라킬" : participant.tripleKills > 0 ? "트리플킬" : participant.doubleKills > 0 ? "더블킬" : "")
                        .font(.caption)
                        .foregroundColor(Color.myColor.red)
                        .padding(participant.pentaKills == 0 && participant.quadraKills == 0 && participant.tripleKills == 0 && participant.doubleKills == 0 ? 0 : 2)
                        .background(RoundedRectangle(cornerRadius: 3).foregroundColor(Color.myColor.red.opacity(0.2)))
                }
                .frame(height: 35)
            }
            
           
        }
        .frame(maxHeight: 115)
    }
}

struct MatchListCell_Previews: PreviewProvider {
    static var previews: some View {
        MatchListCell(matchInfo: myPreviewClass.matchInfo, summoner: myPreviewClass.summoner)
            .preferredColorScheme(.dark)
    }
}
