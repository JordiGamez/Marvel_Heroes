import Foundation
import Alamofire
import Alamofire_Synchronous
import SwiftyJSON
import CryptoSwift

/// Responsible for communication with the Marvel API
class ApiClient: BaseClient {
    
    // MARK: - Constants
    
    let jsonDecoder = JSONDecoder()
    
    // MARK: - Variables

    var domain = ""
    var url = Values.Server.Api.Url.rawValue
}

// MARK: - ApiClientProtocol protocol conformance

extension ApiClient: ApiClientProtocol {
    
    /// Gets the heroes from the Api
    ///
    /// - Parameter offset: Skip the specified number of resources in the result set
    /// - Returns: A HeroEntity object
    /// - Throws: Exception
    func getHeroes(offset: Int = 0) throws -> HeroEntity? {
        
        // Endpoint
        let endpoint = Values.Server.Endpoints.Characters.rawValue
        
        // Limit
        let limit = "limit=\(Values.Server.Api.Limit.rawValue)"
        
        // Offset
        let offset = "offset=\(offset)"
        
        // Timestamp
        let timestamp = String(Date().toMillis())
        
        // Api key
        let apikey = "apikey=\(Values.Server.Api.PublicKey.rawValue)"
        
        // Hash value
        let hash = "hash=\((timestamp + Values.Server.Api.PrivateKey.rawValue + Values.Server.Api.PublicKey.rawValue).md5())"
        
        // Request
        do {
            let result = try doRequest(url: url + endpoint + "?" + limit + "&" + offset + "&ts=" + timestamp + "&" + apikey + "&" + hash, method: .get, encoding: URLEncoding.default, headers: nil)
            
            // Decode
            let heroEntityList = try? jsonDecoder.decode(HeroEntity.self, from: result.response)
            
            return heroEntityList
        } catch let exception as ConnectivityException {
            throw exception
        }
    }
    
    /// Search heroes by name from the Api
    ///
    /// - Parameter name: The name of the hero
    /// - Returns: A HeroEntity object
    /// - Throws: Exception
    func getHeroesBy(name: String) throws -> HeroEntity? {
        
        // Endpoint
        let endpoint = Values.Server.Endpoints.Characters.rawValue
        
        // Name
        let name = "nameStartsWith=\(name)"
        
        // Timestamp
        let timestamp = String(Date().toMillis())
        
        // Api key
        let apikey = "apikey=\(Values.Server.Api.PublicKey.rawValue)"
        
        // Hash value
        let hash = "hash=\((timestamp + Values.Server.Api.PrivateKey.rawValue + Values.Server.Api.PublicKey.rawValue).md5())"
        
        // Request
        do {
            let result = try doRequest(url: url + endpoint + "?" + "&" + name + "&ts=" + timestamp + "&" + apikey + "&" + hash, method: .get, encoding: URLEncoding.default, headers: nil)
            
            // Decode
            let heroEntityList = try? jsonDecoder.decode(HeroEntity.self, from: result.response)
            
            return heroEntityList
        } catch let exception as ConnectivityException {
            throw exception
        }
    }
    
    /// Gets all the available information of a hero
    ///
    /// - Parameter heroId: The hero id
    /// - Returns: A HeroEntity object
    /// - Throws: Exception
    func getHeroDetail(heroId: String) throws -> HeroDetailEntity? {
        
        // Endpoint
        let endpoint = Values.Server.Endpoints.CharacterDetail.rawValue
        
        // Timestamp
        let timestamp = String(Date().toMillis())
        
        // Api key
        let apikey = "apikey=\(Values.Server.Api.PublicKey.rawValue)"
        
        // Hash value
        let hash = "hash=\((timestamp + Values.Server.Api.PrivateKey.rawValue + Values.Server.Api.PublicKey.rawValue).md5())"
        
        // Request
        do {
            let result = try doRequest(url: url + endpoint + heroId + "?&ts=" + timestamp + "&" + apikey + "&" + hash, method: .get, encoding: URLEncoding.default, headers: nil)
            
            // Decode
            let heroDetailEntity = try? jsonDecoder.decode(HeroDetailEntity.self, from: result.response)
            
            return heroDetailEntity
        } catch let exception as ConnectivityException {
            throw exception
        }
    }
    
    /// Gets all the available comic information of a hero
    ///
    /// - Parameter heroId: The hero id
    /// - Returns: A ComicDetailEntity object
    /// - Throws: Exception
    func getComicDetails(heroId: String) throws -> ComicDetailEntity? {
        
        // Endpoint
        var endpoint = Values.Server.Endpoints.CharacterComics.rawValue
        endpoint = endpoint.replacingOccurrences(of: "{heroId}", with: heroId)
        
        // Timestamp
        let timestamp = String(Date().toMillis())
        
        // Api key
        let apikey = "apikey=\(Values.Server.Api.PublicKey.rawValue)"
        
        // Hash value
        let hash = "hash=\((timestamp + Values.Server.Api.PrivateKey.rawValue + Values.Server.Api.PublicKey.rawValue).md5())"
        
        // Request
        do {
            let result = try doRequest(url: url + endpoint + "?&ts=" + timestamp + "&" + apikey + "&" + hash, method: .get, encoding: URLEncoding.default, headers: nil)
            
            // Decode
            let heroDetailEntity = try? jsonDecoder.decode(ComicDetailEntity.self, from: result.response)
            
            return heroDetailEntity
        } catch let exception as ConnectivityException {
            throw exception
        }
    }
}
