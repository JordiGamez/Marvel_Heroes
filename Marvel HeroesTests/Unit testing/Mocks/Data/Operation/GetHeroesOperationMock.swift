import Foundation

/// Operation to load the heroes
class GetHeroesOperationMock {
    
    // MARK: - Variables
    
    var client: ApiClientProtocol
    var internetConnectionAvailable = true
    var heroes: [Hero] = []
    
    // MARK: - Initializers
    
    init(client: ApiClientProtocol) {
        self.client = client
    }
}

// MARK: - GetHeroesOperationProtocol protocol conformance

extension GetHeroesOperationMock: GetHeroesOperationProtocol {
    
    /// Loads the heroes
    ///
    /// - Returns: An array with the list of
    /// - Throws: Exception
    func perform(offset: Int = 0) throws -> [Hero] {
        if internetConnectionAvailable {
            var heroes: [Hero] = []
            
            let heroHulk = Hero()
            heroHulk.name = "Hulk"
            heroHulk.image = "hulk.jpg"
            heroes.append(heroHulk)
            
            let heroSpiderman = Hero()
            heroSpiderman.name = "Hulk"
            heroSpiderman.image = "hulk.jpg"
            heroes.append(heroSpiderman)
            
            return heroes
        } else {
            throw ConnectivityException()
        }
    }
}
