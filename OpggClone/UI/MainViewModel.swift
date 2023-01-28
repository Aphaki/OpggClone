//
//  MainViewModel.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/01/08.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
    @Published var regionPicker: UrlHeadPoint = .kr
    @Published var searchBarText: String = ""
    
    @Published var summonerInfo: SummonerInfo?
    @Published var leagueInfo: [SummonersLeagueElement] = []
    @Published var matchList: MatchIDs = []
    @Published var matchInfos: [MatchInfo] = []
    @Published var matchInfo: MatchInfo?
    
    
    private var service = Service()
    private var subscription = Set<AnyCancellable>()
    
    init() {
        totalSubscribe()
    }
    //MARK: - 구독
    private func subscribeUrlRegion() {
        service.$regionPicker
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("subscribeUrlRegion subscribe completion: \(completion)")
            } receiveValue: { urlHeadPoint in
                self.regionPicker = urlHeadPoint
            }
            .store(in: &subscription)
    }
    private func subscribeSearchBarText() {
        service.$searchBarText
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("subscribeSearchBarText subscribe completion: \(completion)")
            } receiveValue: { receivedValue in
                self.searchBarText = receivedValue
            }
            .store(in: &subscription)
    }
    private func subscribeSummonerInfo() {
        service.$summonerInfo
            .receive(on: DispatchQueue.main)
            .sink { [weak self] receivedInfo in
                self?.summonerInfo = receivedInfo
            }
            .store(in: &subscription)
    }
    private func subscribeLeagueInfo() {
        service.$leagueInfo
            .receive(on: DispatchQueue.main)
            .sink { [weak self] receivedInfo in
                self?.leagueInfo = receivedInfo
            }
            .store(in: &subscription)
    }
    private func subscribeMatchList() {
        service.$matchList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] receivedList in
                self?.matchList = receivedList
            }
            .store(in: &subscription)
    }
    private func subscribeMatchInfos() {
        service.$matchInfos
            .receive(on: DispatchQueue.main)
            .sink { [weak self] receivedList in
                self?.matchInfos = receivedList
            }
            .store(in: &subscription)
    }
    private func totalSubscribe() {
        subscribeUrlRegion()
        subscribeSearchBarText()
        subscribeSummonerInfo()
        subscribeLeagueInfo()
        subscribeMatchList()
        subscribeMatchInfos()
    }
//    func totalRequest() {
//        service.totalRequest()
//    }
    func fetchSummonerInfo(urlBase: UrlHeadPoint, name: String) {
        service.requestSummonerInfo(urlBaseHead: urlBase, name: name)
    }
    
}
