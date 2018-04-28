//
//  BaseClient.swift
//  Marvel Heroes
//
//  Created by Jordi Gamez on 28/4/18.
//  Copyright © 2018 Jordi Gamez. All rights reserved.
//

import Foundation
import Alamofire
import Alamofire_Synchronous
import SwiftyJSON

class BaseClient {
    
    // MARK: - Constants
    
    let tag = String(describing: BaseClient.self)
    
    // MARK: - Initializers
    
    init() {}
    
    // MARK: - Methods
    
    func doRequest(url: String, method: HTTPMethod, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil, attempt: Int = 0, maxNumberOfTries: Int, delayTime: Int) throws -> (response: Data, headers: [AnyHashable: Any]) {
        
        let response = Alamofire.request(url, method: method, encoding: encoding, headers: headers).responseData()
        
        let responseHeaders = response.response?.allHeaderFields
        
        switch response.result {
        case .success(let response):
            return (response, responseHeaders!)
        case .failure:
            if attempt <= maxNumberOfTries {
                
                // Delay
                sleep(UInt32(delayTime))
                
                // Retry the request
                do {
                    _ = try self.doRequest(url: url, method: method, encoding: encoding, headers: headers, attempt: attempt, maxNumberOfTries: maxNumberOfTries, delayTime: delayTime)
                } catch let exception as Exception {
                    throw exception
                }
            } else {
                throw ConnectivityException()
            }
        }
        throw UnknownException()
    }
}
