//
//  ApiClient.swift
//  Marvel Heroes
//
//  Created by Jordi Gamez on 28/4/18.
//  Copyright © 2018 Jordi Gamez. All rights reserved.
//

import Foundation
import Alamofire
import Alamofire_Synchronous
import SwiftyJSON
import CryptoSwift

class ApiClient: BaseClient {
    
    // MARK: - Constants
    
    let jsonDecoder = JSONDecoder()
    
    // MARK: - Variables

    var domain = ""
    var url = Values.Server.Api.Url.rawValue
    var numberOfTries = Settings.Network.Retry.rawValue
    var delay = Settings.Network.Delay.rawValue
    var attempt = 0
}

// MARK: - ApiClientProtocol protocol conformance

extension ApiClient: ApiClientProtocol {
    
    func getHeroes() throws -> HeroEntity? {
        
        // Endpoint
        let endpoint = Values.Server.Endpoints.Characters.rawValue
        
        // Timestamp
        let timestamp = String(Date().toMillis())
        
        // Api key
        let apikey = "apikey=\(Values.Server.Api.PublicKey.rawValue)"
        
        // Hash value
        let hash = "hash=\((timestamp + Values.Server.Api.PrivateKey.rawValue + Values.Server.Api.PublicKey.rawValue).md5())"
        
        // Request
        do {
            let result = try doRequest(url: url + endpoint + "?ts=" + timestamp + "&" + apikey + "&" + hash, method: .get, encoding: URLEncoding.default, headers: nil, attempt: attempt, maxNumberOfTries: numberOfTries, delayTime: delay)
            
            let heroEntityList = try? jsonDecoder.decode(HeroEntity.self, from: result.response)
            
            return heroEntityList
        } catch let exception {
            throw exception
        }
    }
}
