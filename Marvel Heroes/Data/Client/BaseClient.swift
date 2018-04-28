import Foundation
import Alamofire
import Alamofire_Synchronous
import SwiftyJSON

/// Performs the network request
class BaseClient {
    
    // MARK: - Constants
    
    let tag = String(describing: BaseClient.self)
    
    // MARK: - Initializer
    
    init() {}
    
    // MARK: - Methods
    
    /// Request
    ///
    /// - Parameters:
    ///   - url: The complete url
    ///   - method: The method to perform the request
    ///   - encoding: The encoding of the request
    ///   - headers: The headers to send to the request
    ///   - attempt: The number of the attempt of this request (MAX numberOfTries)
    ///   - maxNumberOfTries: The maximum number of tries
    ///   - delayTime: The delay after each try
    /// - Returns: Response data and response headers
    /// - Throws: Exception
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
