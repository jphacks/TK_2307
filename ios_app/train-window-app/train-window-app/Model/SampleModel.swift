//
//  SampleModel.swift
//  train-window-app
//
//  Created by yuuta on 2023/10/26.
//

import Foundation
import Alamofire

struct PingResponse: Codable {
    var pings: [Ping]
}
struct Ping: Codable {
    var ping: String
    var pingId: String
}

struct CreatePingRequest: Codable {
    var ping: String
    
    var dict: [String: Any] {
        return [
            "ping": ping
        ]
    }
}
struct CraetePingResponse: Codable {
    var createdPing: Ping
}

struct SampleModel: Decodable {

    func getPing() {
        AF.request(HttpConnect.baseURL+"/getPing", method: .get).response { response in
            do {
                let resObj = try JSONDecoder().decode(PingResponse.self, from: response.data!)
                print(resObj)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func postPing() {
        let params = CreatePingRequest(ping: "pooong")
        AF.request(
            HttpConnect.baseURL+"/createPing",
            method: .post,
            parameters: params.dict,
            encoding: JSONEncoding.default
        ).response { response in
            do {
                let res = try JSONDecoder().decode(CraetePingResponse.self, from: response.data!)
                print(res)
            } catch {
                print(error)
            }
        }
    }    
}
