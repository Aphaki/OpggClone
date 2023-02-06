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
    @Published var isLoading: Bool = false
    
    @Published var searchedDetail: DetailSummonerInfo?
    @Published var myDetailSummonerInfo: DetailSummonerInfo?
    @Published var searchedSummonersDetail: [DetailSummonerInfo] = []
    @Published var bookMarkSummonersDetail: [DetailSummonerInfo] = []
    
    @Published var noSummonerError = PassthroughSubject<(),Never>()

    
    private var service = Service()
    private var subscription = Set<AnyCancellable>()
    
    init() {
        totalSubscribe()
    }
    

    func saveMyDetail(urlBase: UrlHeadPoint, name: String) {
        
        Task {
            try await service.saveMyDetail(urlBase: urlBase, name: name)
        }
        
    }
    
    func saveSearchedDetail(urlBase: UrlHeadPoint, name: String) async throws {
        
        try await service.saveSearchedSummonerDetail(urlBase: urlBase, name: name)
    }
    
    func duplicateCheckAndAdd(aDetailSummoner: DetailSummonerInfo) {
        service.duplicateCheckAndAdd(aDetailSummoner: aDetailSummoner)
    }
    
    //MARK: - 구독
    private func subscribeUrlRegion() {
        service.$regionPicker
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("subscribeUrlRegion subscribe completion: \(completion)")
            } receiveValue: { [weak self] urlHeadPoint in
                self?.regionPicker = urlHeadPoint
            }
            .store(in: &subscription)
    }
    private func subscribeSearchBarText() {
        service.$searchBarText
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("subscribeSearchBarText subscribe completion: \(completion)")
            } receiveValue: { [weak self] receivedValue in
                self?.searchBarText = receivedValue
            }
            .store(in: &subscription)
    }
    private func subscribeIsLoading() {
        service.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.isLoading = value
            }
            .store(in: &subscription)
    }
    private func subscribeSearchedDetail() {
        service.$searchedDetail
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.searchedDetail = value
            }
            .store(in: &subscription)
    }
    private func subscribemyDetailSummonerInfo() {
        service.$myDetailSummonerInfo
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value  in
                self?.myDetailSummonerInfo = value
            }
            .store(in: &subscription)
    }
    private func subscribeSearchedSummonersDetail() {
        service.$searchedSummonersDetail
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.searchedSummonersDetail = value
            }
            .store(in: &subscription)
    }
    private func subscribeBookmarkSummonersDetail() {
        service.$bookMarkSummonersDetail
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.bookMarkSummonersDetail = value
            }
            .store(in: &subscription)
    }
    private func subscribeNoSummonerError() {
        service.$noSummonerError
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.noSummonerError = value
            }
            .store(in: &subscription)
        
    }
    
    
    private func totalSubscribe() {
        subscribeUrlRegion()
        subscribeSearchBarText()
        subscribeIsLoading()
        
        subscribeSearchedDetail()
        subscribemyDetailSummonerInfo()
        subscribeSearchedSummonersDetail()
        subscribeBookmarkSummonersDetail()
        subscribeNoSummonerError()
    }

    
}
