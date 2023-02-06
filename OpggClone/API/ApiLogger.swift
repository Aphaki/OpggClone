//
//  ApiLogger.swift
//  OpggClone
//
//  Created by Sy Lee on 2022/12/29.
//

import Foundation
import Alamofire

class ApiLogger: EventMonitor {
    let queue: DispatchQueue = DispatchQueue(label: "MyLab_ApiLogger")
    
    func requestDidResume(_ request: Request) {
        print("ApiLogger - requestDidResume() - \(request)")
    }
    
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        debugPrint("ApiLogger - Finished: \(response)")
    }
}
