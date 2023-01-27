//
//  ApiClient.swift
//  OpggClone
//
//  Created by Sy Lee on 2022/12/29.
//

import Foundation
import Alamofire

final class ApiClient {
    static let shared = ApiClient()
    
    let interceptors = Interceptor(interceptors: [BaseInterceptor()])
    
    let monitors: [EventMonitor] = [ApiLogger()]
    
    var session: Session
    
    init() {
        print("ApiClient - init()")
        session = Session(interceptor: interceptors, eventMonitors: monitors)
    }
}
