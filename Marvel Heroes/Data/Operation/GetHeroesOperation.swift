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
    /// - Parameter offset: Skip the specified number of resources in the result set
    /// - Returns: A list with the heroes
    /// - Throws: Exception
    func perform(offset: Int = 0) throws -> [Hero] {
        do {
            let result = try client.getHeroes(offset: offset)
            let heroMapper = HeroMapper()
            return heroMapper.transform(result!)
        } catch let exception as ConnectivityException {
            throw exception
        }
    }
}
