//
//  SearchedUserCell.swift
//  OpggClone
//
//  Created by Sy Lee on 2022/12/26.
//

import SwiftUI

struct SearchedUserCell: View {
    
    //property: IconImageName, Summoner Name, Tier Image, Tier Name
    
    var body: some View {
        HStack {
            Image(systemName: "person.fill")
                .font(.title)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text("Summoner Name")
                    .font(.headline)
                HStack(spacing: 0) {
                    Image(systemName: "seal.fill")
                    Text("D3(Tier)")
                }
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
        .frame(width: 375, height: 150)
    }
}

struct SearchedUserCell_Previews: PreviewProvider {
    static var previews: some View {
        SearchedUserCell()
    }
}
