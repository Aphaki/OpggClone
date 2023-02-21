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
    case match(urlBaseHead:UrlHeadPoint, puuid: String, start: Int = 0, count: Int = 20)
    case matchInfo(urlBaseHead:UrlHeadPoint, matchId: String)
    case inGameInfo(urlBaseHead: UrlHeadPoint, encryptedSummonerId: String)

    var baseURL: URL {
        switch self {
        case let .summoner(urlBaseHead, _):
            return URL(string: urlBaseHead.urlBaseString)!
        case let .league(urlBaseHead, _):
            return URL(string: urlBaseHead.urlBaseString)!
        case let .match(urlBaseHead, _, _, _):
            return URL(string: urlBaseHead.urlBaseAreaString)!
        case let .matchInfo(urlBaseHead, _):
            return URL(string: urlBaseHead.urlBaseAreaString)!
        case let .inGameInfo(urlBaseHead, _):
            return URL(string: urlBaseHead.urlBaseString)!
        }
    }

    var method: HTTPMethod {
        return .get
    }
    var path: String {
        switch self {
        case let .summoner(_, name):
            return "lol/summoner/v4/summoners/by-name/\(name)"
        case let .league(_, encryptedSummonerId):
            return "lol/league/v4/entries/by-summoner/\(encryptedSummonerId)"
        case let .match(_, puuid, _, _):
            return "lol/match/v5/matches/by-puuid/\(puuid)/ids"
        case let .matchInfo(_, matchID):
            return "lol/match/v5/matches/\(matchID)"
        case let .inGameInfo(_, encryptedSummonerId):
            return "lol/spectator/v4/active-games/by-summoner/\(encryptedSummonerId)"
        }
    }
    
//    var parameter: [String:String] {
//
//        return [ "api_key" : MyConstants.X_Riot_Token ]
//    }
    
    var parameter: [String:Int] {
        switch self {
        case let .match(_, _, start, count):
            return ["start" : start , "count" : count]
        default:
            return [:]
        }
    }

    func asURLRequest() throws -> URLRequest {

        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        request = try URLEncodedFormParameterEncoder().encode(parameter, into: request)
        print("\(request)")

        return request
    }
    
}
