//
//  EmptyMySummonerCard.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/02/01.
//

import SwiftUI

struct EmptyMySummonerCard: View {
    
    var body: some View {
        
        VStack {
            HStack(spacing: 15) {
                Spacer()
                Image(systemName: "questionmark.bubble.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                VStack(alignment: .leading, spacing: 10) {
                    Text("내 KDA는 몇점?")
                    Text("내가 가장 잘하는 챔피언은?")
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.myColor.backgroundColor))
            .padding()
            VStack {
                Text("소환사를 검색해서 등록해주세요!")
                Text("나의 전적을 분석해 도움을 줍니다.")
                Button {
                    
                } label: {
                    Text("소환사 등록하기")
                        .foregroundColor(Color.myColor.lightBlue)
                        .frame(maxWidth: .infinity)
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.myColor.darkBlue))
                        .padding()
                }

            }
        }
        
    }
}

struct EmptyMySummonerCard_Previews: PreviewProvider {
    static var previews: some View {
        EmptyMySummonerCard()
    }
}
