import Foundation

/// Operation to search heroes
class SearchHeroesOperation {
    
    // MARK: - Variables
    
    var client: ApiClientProtocol
    
    // MARK: - Initializers
    
    init(client: ApiClientProtocol) {
        self.client = client
    }
}

// MARK: - SearchHeroesOperationProtocol protocol conformance

extension SearchHeroesOperation: SearchHeroesOperationProtocol {
    
    /// Loads the heroes
    ///
    /// - Parameter name: The name of the hero
    /// - Returns: A list with the heroes
    /// - Throws: Exception
    func perform(name: String) throws -> [Hero] {
        do {
            let result = try client.getHeroesBy(name: name)
            let heroMapper = HeroMapper()
            return heroMapper.transform(result!)
        } catch let exception as ConnectivityException {
            throw exception
        }
    }
}
