//
//  Router.swift
//  OpggClone
//
//  Created by Sy Lee on 2022/12/30.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    case searchSummoner(name: String)
    
    
    
    func asURLRequest() throws -> URLRequest {
        
        return
    }
}
