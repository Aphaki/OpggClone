//
//  InGameBanCell.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/02/20.
//

import SwiftUI

struct InGameBanCell: View {
    
    let champDicKeyToId = JsonInstance.shared.champKeyToId
    var blueTeam: [SpParticipant]
    var redTeam: [SpParticipant]
    
    var blueTeamChampKey: [String] {
        let keyArray =
        blueTeam.map { aParticipant in
            return aParticipant.championID.description
        }
        return keyArray
    }
    var redTeamChampKey: [String] {
        let keyArray =
        redTeam.map { aParticipant in
            return aParticipant.championID.description
        }
        return keyArray
    }
    
    
    var body: some View {
        
        HStack {
            HStack(spacing: 5) {
                ForEach(blueTeamChampKey, id: \.self) { aKey in
                    AsyncImage(url: champDicKeyToId[aKey.description]!.toChampImgURL()) { img in
                        img
                            .resizable()
                            .frame(width: 25, height: 25)
                            .clipShape(Circle())
                            .opacity(0.5)
                    } placeholder: {
                        ProgressView()
                    }
                }
            }
            Spacer()
            Text("밴")
                .font(.headline)
                .foregroundColor(Color.myColor.red)
                .padding(3)
                .background(RoundedRectangle(cornerRadius: 5).foregroundColor(Color.myColor.red).opacity(0.3))
            Spacer()
            HStack(spacing: 5) {
                ForEach(redTeamChampKey, id: \.self) { aKey in
                    AsyncImage(url: champDicKeyToId[aKey.description]!.toChampImgURL()) { img in
                        img
                            .resizable()
                            .frame(width: 25, height: 25)
                            .clipShape(Circle())
                            .opacity(0.5)
                    } placeholder: {
                        ProgressView()
                    }
                }
            }
        }
    }
}

struct InGameBanCell_Previews: PreviewProvider {
    static var previews: some View {
        InGameBanCell(blueTeam: myPreviewClass.blueTeam, redTeam: myPreviewClass.redTeam)
    }
}
