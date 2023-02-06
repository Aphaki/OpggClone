//
//  MySummonerAddView.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/02/01.
//

import SwiftUI

struct MySummonerAddView: View {
    
    @EnvironmentObject var mainVM: MainViewModel
    
    @State var textString: String = ""
    @Binding var goToAddView: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                VStack(alignment: .leading) {
                    Text("LOGO")
                        .foregroundColor(Color.myColor.darkBlue)
                        .font(.largeTitle)
                        .padding(.vertical, 10)
                    Text("내 소환사를 등록해주세요!")
                    Text("전적을 분석해 도움을 줍니다.")
                }
                .padding(.leading, 20)
                Spacer()
            }
            .padding(.bottom, 20)
            TextField("소환사 아이디", text: $textString)
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(Color.myColor.gray))
                .padding(.horizontal, 10)
            Button {
                mainVM.saveMyDetail(urlBase: mainVM.regionPicker, name: textString)
                
                goToAddView.toggle()
            } label: {
                Text("완료")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.myColor.gray))
                    .padding(.horizontal, 10)
            }
            Spacer()

        }
                
       
    }
}

struct MySummonerAddView_Previews: PreviewProvider {
    static var previews: some View {
        MySummonerAddView(goToAddView: .constant(true))
    }
}
