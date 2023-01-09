//
//  BaseInterceptor.swift
//  OpggClone
//
//  Created by Sy Lee on 2022/12/29.
//

import Foundation
import Alamofire


class BaseInterceptor: RequestInterceptor {
    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        
        request.addValue("ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7", forHTTPHeaderField: "Accept-Language")
        request.addValue("application/x-www-form-urlencoded; charset=UTF-8", forHTTPHeaderField: "Accept-Charset")
        request.addValue("https://developer.riotgames.com", forHTTPHeaderField: "Origin")
        
        //2022.12.29
        request.addValue("RGAPI-0ab79807-fd6d-4186-a0f7-d562d7b404b0", forHTTPHeaderField: "X-Riot-Token")
        
        completion(.success(request))
    }
}