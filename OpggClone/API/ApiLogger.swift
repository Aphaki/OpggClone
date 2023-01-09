//
//  ApiLogger.swift
//  OpggClone
//
//  Created by Sy Lee on 2022/12/29.
//

import Foundation
import Alamofire

final class ApiLogger: EventMonitor {
    let queue = DispatchQueue(label: "Riot_API_Logger")
    
    /// Event called when a `Request` receives a `resume` call.
    func requestDidResume(_ request: Request) {
        print("ApiLogger: RequestDidResume() 발동")
    }
    
    /// Event called when a `DataRequest` calls a `ResponseSerializer` and creates a generic `DataResponse<Value, AFError>`.
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        debugPrint("ApiLogger - Finished: \(response)")
    }
}
