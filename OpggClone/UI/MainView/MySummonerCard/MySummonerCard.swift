//
//  MySummonerCard.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/01/06.
//

import SwiftUI

struct MySummonerCard: View {
    
    @EnvironmentObject var mainVM: MainViewModel
    
    @Binding var mySummonerInfo: DetailSummonerInfo?
    @Binding var goToAddView: Bool
    @Binding var regionPicker: UrlHeadPoint
    
    @State var deleteAlert: Bool = false
    @State var goToDetailView: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            
            if mySummonerInfo != nil {
                VStack {
                    HStack {
                        AsyncImage(url: mySummonerInfo!.icon.toIconImgURL()) { img in
                            img
                                .resizable()
                                .frame(width: 70, height: 70)
                                .clipShape(Circle())
                                .overlay {
                                    VStack {
                                        Spacer()
                                        Text("\(mySummonerInfo!.level)")
                                            .font(.caption)
                                            .background {
                                                RoundedRectangle(cornerRadius: 10).foregroundColor(Color.myColor.gray)
                                            }
                                    }
                                    
                                }
                        } placeholder: {
                            ProgressView()
                        }
                        VStack(alignment: .leading, spacing: 5) {
                            Text(mySummonerInfo!.summonerName)
                                .foregroundColor(Color.myColor.accentColor)
                                .font(.title)
                            HStack {
                                Text(mySummonerInfo!.tier == "provisional" ? "Unranked" : mySummonerInfo!.tier)
                                Text(mySummonerInfo!.rank)
                                Image(mySummonerInfo!.tier.lowercased())
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                Text("|  " + mySummonerInfo!.point.description + "LP")
                            }
                            .font(.caption)
                            
                            
                        }
                        Spacer()
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .onTapGesture {
                                deleteAlert.toggle()
                            }
                            .alert("??? ???????????? ?????????????????????????", isPresented: $deleteAlert) {
                                HStack {
                                    Button(role: .destructive) {
                                        mySummonerInfo = nil
                                        print("??? ????????? ??????")
                                    } label: {
                                        Text("OK")
                                    }
                                }
                               
                            }

                    }
                    .padding(.vertical, 10)
                    VStack {
                        HStack {
                            Text(mySummonerInfo!.winCount.description + "???")
                                .font(.headline)
                            Text(mySummonerInfo!.loseCount.description + "???")
                                .font(.headline)
                            Text(mySummonerInfo!.totalWinningRate.description + "%")
                                .font(.headline)
                            Text(mySummonerInfo!.totalKda.with2Demicals() + ":1")
                                .foregroundColor(mySummonerInfo!.totalKda > 6 ? .red : mySummonerInfo!.totalKda > 4 ? .blue : mySummonerInfo!.totalKda > 3 ? .green : .gray)
                        }
                        HStack(spacing: 10) {
                            ForEach(mySummonerInfo!.mostChamp) { aMostChamp in
                                ChampCell(champName: aMostChamp.championName, winningRate: aMostChamp.winningRate, kda: aMostChamp.kda)
                            }

                        }
                    }
                    .frame(maxWidth: .infinity, minHeight: 120)
                    .background(RoundedRectangle(cornerRadius: 5).foregroundColor(Color.myColor.secondary))
                    Button {
                        print("????????? ?????? ?????? ??????")
                        goToDetailView.toggle()
                    } label: {
                        Text("????????? ??????")
                            .foregroundColor(.white)
                            .padding(10)
                            .frame(maxWidth: .infinity, minHeight: 55)
                            .background(RoundedRectangle(cornerRadius: 5).foregroundColor(Color.myColor.darkBlue))
                    }
                    .navigationDestination(isPresented: $goToDetailView) {
                        MySummonerLoadingView(mySummonerInfo: mainVM.myDetailSummonerInfo, regionPicker: $regionPicker)
                    }

                } // VStack
            } else {
                EmptyMySummonerCard(goToAddView: $goToAddView)
            }
            
        }
       
    }
}

//struct MySummonerCard_Previews: PreviewProvider {
//    static var previews: some View {
//        MySummonerCard()
//            .preferredColorScheme(.dark)
//    }
//}




