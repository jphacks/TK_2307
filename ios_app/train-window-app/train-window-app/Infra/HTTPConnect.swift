//
//  HTTPConnect.swift
//  train-window-app
//
//  Created by yuuta on 2023/10/27.
//

import Foundation
import EzHTTP

class HttpConnect {
    static let baseURL = "https://us-central1-trainwindowguide.cloudfunctions.net"
    
    static func sendGetRequet(path: String) -> Data {
        let r = HTTP.getSync(baseURL+path)
        return r.dataValue
    }
    
    static func sendPostRequest(path: String, requestData: Data) -> Data {
        let r = HTTP.requestSync(.POST, baseURL+path, json: ["ping": "pong"])
        print(r.error!)
        print(r.dataValue)
        return r.dataValue
    }
}
