import Foundation

/// Operation to load the hero detail mock
class GetHeroDetailOperationMock {
    
    // MARK: - Variables
    
    var client: ApiClientProtocol
    var internetConnectionAvailable = true
    var hero = Hero()
    var performIsCalled = false
    
    // MARK: - Initializers
    
    init(client: ApiClientProtocol) {
        self.client = client
    }
}

// MARK: - GetHeroDetailOperationProtocol protocol conformance

extension GetHeroDetailOperationMock: GetHeroDetailOperationProtocol {
    
    /// Loads the hero information
    ///
    /// - Parameter heroId: The id of the hero
    /// - Returns: A list with the hero information
    /// - Throws: Exception
    func perform(heroId: String) throws -> Hero {
        performIsCalled = true
        if internetConnectionAvailable {
            return hero
        } else {
            throw ConnectivityException()
        }
    }
}

