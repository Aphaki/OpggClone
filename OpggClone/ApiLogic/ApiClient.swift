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
    
    let interceptors = Interceptor(interceptors: [])
    
    let monitors = [ApiLogger()] as [EventMonitor]
    
    var session: Session
    
    init() {
        print("ApiClient- init() called")
        session = Session(interceptor: interceptors, eventMonitors: monitors)
    }
    
}
