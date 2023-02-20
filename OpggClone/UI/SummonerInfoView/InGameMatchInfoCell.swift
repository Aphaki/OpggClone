//
//  InGameMatchInfoCell.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/02/20.
//

import SwiftUI

struct InGameMatchInfoCell: View {
    
    let blueTeamMember: SpParticipant
    let redTeamMember: SpParticipant
    
    let champDicKeyToId = JsonInstance.shared.champKeyToId
    let spellStore = JsonInstance.shared.spellStore
    let primaryRuneDic = JsonInstance.shared.primaryRuneDic
    let detatilRuneDic = JsonInstance.shared.detailRuneDic
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack(spacing: 0) {
                    // 챔피언 이미지
                    AsyncImage(url: champDicKeyToId[blueTeamMember.championID.description]?.toChampImgURL()) { img in
                        img
                            .resizable()
                            .frame(width: 60, height: 60)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    } placeholder: {
                        ProgressView()
                    }
                    .padding(.trailing, 10)
                    // 스펠
                    VStack(spacing: 1) {
                        AsyncImage(url: URL(string: "https://ddragon.leagueoflegends.com/cdn/13.1.1/img/spell/\(String(describing: spellStore[blueTeamMember.spell1ID.description] ?? "")).png")) { img in
                            img
                                .resizable()
                                .frame(width: 25, height: 25)
                                .clipShape(RoundedRectangle(cornerRadius: 7))
                        } placeholder: {
                            ProgressView()
                        }
                        AsyncImage(url: URL(string: "https://ddragon.leagueoflegends.com/cdn/13.1.1/img/spell/\(String(describing: spellStore[blueTeamMember.spell2ID.description] ?? "")).png")) { img in
                            img
                                .resizable()
                                .frame(width: 25, height: 25)
                                .clipShape(RoundedRectangle(cornerRadius: 7))
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    // 룬
                    VStack(spacing: 2) {
                        
                        AsyncImage(url: URL(string:  "https://ddragon.leagueoflegends.com/cdn/img/" + (detatilRuneDic[blueTeamMember.spPerks.perkIDS.first!] ?? ""))) { img in
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
                        AsyncImage(url: URL(string: "https://ddragon.leagueoflegends.com/cdn/img/" + (primaryRuneDic[blueTeamMember.spPerks.perkStyle] ?? ""))) { img in
                            img
                                .resizable()
                                .frame(width: 25, height: 25)
                                .clipShape(RoundedRectangle(cornerRadius: 7))
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
                
                Text(blueTeamMember.summonerName)
                    .font(.headline)
            }
            Spacer()
            VStack(alignment: .trailing) {
                HStack(spacing: 0) {
                    
                    // 룬
                    VStack(spacing: 2) {
                        
                        AsyncImage(url: URL(string:  "https://ddragon.leagueoflegends.com/cdn/img/" + (detatilRuneDic[redTeamMember.spPerks.perkIDS.first!] ?? ""))) { img in
                            img
                                .resizable()
                                .frame(width: 25, height: 25)
                                .clipShape(RoundedRectangle(cornerRadius: 7))
                        } placeholder: {
                            ProgressView()
                        }
                        
                        AsyncImage(url: URL(string: "https://ddragon.leagueoflegends.com/cdn/img/" + (primaryRuneDic[redTeamMember.spPerks.perkStyle] ?? ""))) { img in
                            img
                                .resizable()
                                .frame(width: 25, height: 25)
                                .clipShape(RoundedRectangle(cornerRadius: 7))
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    // 스펠
                    VStack(spacing: 1) {
                        AsyncImage(url: URL(string: "https://ddragon.leagueoflegends.com/cdn/13.1.1/img/spell/\(String(describing: spellStore[redTeamMember.spell1ID.description] ?? "")).png")) { img in
                            img
                                .resizable()
                                .frame(width: 25, height: 25)
                                .clipShape(RoundedRectangle(cornerRadius: 7))
                        } placeholder: {
                            ProgressView()
                        }
                        AsyncImage(url: URL(string: "https://ddragon.leagueoflegends.com/cdn/13.1.1/img/spell/\(String(describing: spellStore[redTeamMember.spell2ID.description] ?? "")).png")) { img in
                            img
                                .resizable()
                                .frame(width: 25, height: 25)
                                .clipShape(RoundedRectangle(cornerRadius: 7))
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    // 챔피언 이미지
                    AsyncImage(url: champDicKeyToId[redTeamMember.championID.description]?.toChampImgURL()) { img in
                        img
                            .resizable()
                            .frame(width: 60, height: 60)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    } placeholder: {
                        ProgressView()
                    }
                    .padding(.leading, 10)
                }
                
                Text(redTeamMember.summonerName)
                    .font(.headline)

            }
        }
        
        
        
        
    }
}

struct InGameMatchInfoCell_Previews: PreviewProvider {
    static var previews: some View {
        InGameMatchInfoCell(blueTeamMember: myPreviewClass.blueTeam.first!, redTeamMember: myPreviewClass.redTeam.first!)
    }
}
