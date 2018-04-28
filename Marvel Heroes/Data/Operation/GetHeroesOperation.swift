import Foundation

/// Operation to load the heroes
class GetHeroesOperation {
    
    // MARK: - Variables
    
    var client: ApiClientProtocol
    
    // MARK: - Initializers
    
    init(client: ApiClientProtocol) {
        self.client = client
    }
}

// MARK: - GetHeroesOperationProtocol protocol conformance

extension GetHeroesOperation: GetHeroesOperationProtocol {

    /// Loads the heroes
    ///
    /// - Returns: An array with the list of
    /// - Throws: Exception
    func perform() throws -> [Hero] {
        do {
            let result = try client.getHeroes()
            let heroMapper = HeroMapper()
            return heroMapper.transform(result!)
        } catch let exception {
            throw exception
        }
    }
}
