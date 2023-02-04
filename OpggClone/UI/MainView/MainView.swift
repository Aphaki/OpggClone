//
//  ContentView.swift
//  OpggClone
//
//  Created by Sy Lee on 2022/12/23.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var mainVM: MainViewModel
    
    @State var goSearchView: Bool = false
    @State var goToAddView: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                SearchBarImageView()
                    .padding(10)
                    .onTapGesture {
                        goSearchView.toggle()
                    }
                    .navigationDestination(isPresented: $goSearchView) {
                        SearchView()
                    }
                    .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.myColor.secondary))
                if mainVM.isLoading == false {
                    MySummonerCard(mySummonerInfo: $mainVM.myDetailSummonerInfo, goToAddView: $goToAddView)
                } else {
                    ProgressView()
                        .frame(width: 200, height: 200)
                }
                Spacer()

                    
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Picker("Kr", selection: $mainVM.regionPicker) {
                        Text("Kr").tag(UrlHeadPoint.kr)
                        Text("Br").tag(UrlHeadPoint.tr1)
                        Text("Jp").tag(UrlHeadPoint.jpOne)
                        Text("Ru").tag(UrlHeadPoint.ru)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("홈편집 버튼 클릭")
                    } label: {
                        ZStack(alignment: .trailing) {
                            Image(systemName: "line.3.horizontal")
                                .foregroundColor(.white)
                            Image(systemName: "arrow.down")
                                .resizable()
                                .frame(width: 10, height: 15)
                                .foregroundColor(.white)
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("logo".uppercased())
                        .font(.largeTitle)
                        .foregroundColor(Color.myColor.darkBlue)
                }
            }
            .navigationDestination(isPresented: $goToAddView) {
                MySummonerAddView(goToAddView: $goToAddView)
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .edgesIgnoringSafeArea(.bottom)
        
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MainView()
                .environmentObject(myPreviewClass.mainVM)
                .background(Color.myColor.appBG)
                .preferredColorScheme(.dark)
        }
    }
}
