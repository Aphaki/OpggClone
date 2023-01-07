//
//  Router.swift
//  OpggClone
//
//  Created by Sy Lee on 2022/12/30.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    case summoner(urlBaseHead:UrlHeadPoint, name: String)
    case league(urlBaseHead:UrlHeadPoint, encryptedSummonerId: String)
    case match(urlBaseHead:UrlHeadPoint, puuid: String)
    case matchInfo(urlBaseHead:UrlHeadPoint, matchId: String)
    
    var baseURL: URL {
        switch self {
        case let .summoner(urlBaseHead, _):
            return URL(string: urlBaseHead.urlBaseString)!
        case let .league(urlBaseHead, _):
            return URL(string: urlBaseHead.urlBaseString)!
        case let .match(urlBaseHead, _):
            return URL(string: urlBaseHead.urlBaseAreaString)!
        case let .matchInfo(urlBaseHead, _):
            return URL(string: urlBaseHead.urlBaseAreaString)!
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    var path: String {
        switch self {
        case let .summoner(_, name):
            return "/lol/summoner/v4/summoners/by-name/\(name)"
        case let .league(_, encryptedSummonerId):
            return "/lol/league/v4/entries/by-summoner/\(encryptedSummonerId)"
        case let .match(_, puuid):
            return "/lol/match/v5/matches/by-puuid/\(puuid)/ids"
        case let .matchInfo(_, matchID):
            return "/lol/match/v5/matches/\(matchID)"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let url = baseURL.appendingPathExtension(path)
        var request = URLRequest(url: url)
        request.method = method
        
        return request
    }
}
