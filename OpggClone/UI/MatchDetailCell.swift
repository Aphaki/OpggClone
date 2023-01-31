//
//  MatchDetailCell.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/01/18.
//

import SwiftUI

struct MatchDetailCell: View {
    
    var participant: Participant
    var matchInfo: MatchInfo
    var summonerInfo: SummonerInfo
    
    private var csPerMinute: String {
        let value =
        Double(participant.totalMinionsKilled) / Double(matchInfo.info.gameDuration) * 60
        let csPerMinuite = value.with1Demical()
        
        return csPerMinuite
    }
    private var maxDealt: Int {
        let dealts =
        matchInfo.info.participants.map { participant in
            return participant.totalDamageDealtToChampions
        }
        let value = dealts.max()
        return value ?? 0
    }
    private var mythicItemInt: Int {
        let value =  participant.challenges["mythicItemUsed"]
        let valueInt = Int(value ?? 0.0)
        return valueInt
    }
    
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
                        .frame(width: 45, height: 45)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                } placeholder: {
                    ProgressView()
                }
                Text("\(participant.champLevel)")
                    .font(.caption)
                    .foregroundColor(.white)
                    .background(RoundedRectangle(cornerRadius: 5).foregroundColor(Color.myColor.gray))
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
                AsyncImage(url: URL(string: "https://ddragon.leagueoflegends.com/cdn/img/" + (detatilRuneDic[participant.perks.styles[0].selections[0].perk] ?? ""))) { img in
                    img
                        .resizable()
                        .frame(width: 20, height: 20)
                        .clipShape(RoundedRectangle(cornerRadius: 3))
                        .background(RoundedRectangle(cornerRadius: 5).foregroundColor(Color.myColor.black))
                } placeholder: {
                    ProgressView()
                }
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
                HStack {
                    Text(participant.summonerName)
                }
                HStack(spacing: 5) {
                    Text(" \(participant.kills)")
                    Text("/")
                    Text("\(participant.deaths)")
                        .foregroundColor(Color.myColor.red)
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
                    ItemImage(itemNumber: participant.item0, width: 20, height: 20, mythicItemInt: mythicItemInt)
                    ItemImage(itemNumber: participant.item1, width: 20, height: 20, mythicItemInt: mythicItemInt)
                    ItemImage(itemNumber: participant.item2, width: 20, height: 20, mythicItemInt: mythicItemInt)
                    ItemImage(itemNumber: participant.item3, width: 20, height: 20, mythicItemInt: mythicItemInt)
                    ItemImage(itemNumber: participant.item4, width: 20, height: 20, mythicItemInt: mythicItemInt)
                    ItemImage(itemNumber: participant.item5, width: 20, height: 20, mythicItemInt: mythicItemInt)
                    ItemImage(itemNumber: participant.item6, width: 20, height: 20, mythicItemInt: mythicItemInt)
                }
                HStack(spacing: 2) {
                    Text("\(participant.totalMinionsKilled)(\(csPerMinute)) / \(participant.goldEarned.withKString())")
                        .font(.caption2)
                    Spacer()
                    
                    DealtBar(maxDealt: maxDealt, dealt: participant.totalDamageDealtToChampions, teamId: participant.teamID)
                    
                }
            }
            .frame(width: 150)
        }
        .background(summonerInfo.puuid == participant.puuid ? Color.myColor.darkBlue.opacity(0.5) : .clear)
    }
}

struct MatchDetailCell_Previews: PreviewProvider {
    static var previews: some View {
        MatchDetailCell(participant: myPreviewClass.aSummonerInfo, matchInfo: myPreviewClass.matchInfo, summonerInfo: myPreviewClass.summoner)
            
    }
}
