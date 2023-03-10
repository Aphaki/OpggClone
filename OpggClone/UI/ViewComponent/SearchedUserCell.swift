//
//  SearchedUserCell.swift
//  OpggClone
//
//  Created by Sy Lee on 2022/12/26.
//

import SwiftUI

struct SearchedUserCell: View {
    
    //property: IconImageName, Summoner Name, Tier Image, Tier Name
//    var starMarkOn: Bool
//
//    init(starMarkOn: Bool) {
//        self.starMarkOn = starMarkOn
//    }
    
    var body: some View {
        HStack {
            ZStack(alignment: .bottom) {
                Image("4416")
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 60, height: 60)
                Text("589")
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(1)
                    .background(RoundedRectangle(cornerRadius: 7).foregroundColor(.secondary))
            }
            VStack(alignment: .leading,spacing: 5) {
                Text("Kwanoo")
                    .font(.headline)
                HStack(spacing: 0) {
                    Text("Diamond 3  ")
                    Image("DIAMOND".lowercased())
                        .resizable()
                        .frame(width: 13, height: 13)
                    Text("ㅣ36 LP")
                }
                .foregroundColor(Color.myColor.accentColor)
                .font(.caption)
            }
            Spacer()
            HStack(spacing: 15) {
                
                Image(systemName: "star")
                
                Image(systemName: "xmark")
            }
            .font(.title)
        }
        .padding(.horizontal, 5)
    }
}

struct SearchedUserCell_Previews: PreviewProvider {
    static var previews: some View {
        SearchedUserCell()
    }
    
}
