import Foundation

/// Operation to load the hero detail
class GetHeroDetailOperation {
    
    // MARK: - Variables
    
    var client: ApiClientProtocol
    
    // MARK: - Initializers
    
    init(client: ApiClientProtocol) {
        self.client = client
    }
}

// MARK: - GetHeroDetailOperationProtocol protocol conformance

extension GetHeroDetailOperation: GetHeroDetailOperationProtocol {
    
    /// Loads the hero information
    ///
    /// - Parameter heroId: The id of the hero
    /// - Returns: A list with the hero information
    /// - Throws: Exception
    func perform(heroId: String) throws -> Hero {
        do {
            let result = try client.getHeroDetail(heroId: heroId)
            let heroDetailMapper = HeroDetailMapper()
            return heroDetailMapper.transform(result!)
        } catch let exception as ConnectivityException {
            throw exception
        }
    }
}
