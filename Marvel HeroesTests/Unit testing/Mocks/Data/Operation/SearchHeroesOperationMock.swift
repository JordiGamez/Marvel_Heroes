import Foundation

/// Operation to search heroes mock
class SearchHeroesOperationMock {
    
    // MARK: - Variables
    
    var client: ApiClientProtocol
    var internetConnectionAvailable = true
    var heroes: [Hero] = []
    var performIsCalled = false
    
    // MARK: - Initializers
    
    init(client: ApiClientProtocol) {
        self.client = client
    }
}

// MARK: - SearchHeroesOperationProtocol protocol conformance

extension SearchHeroesOperationMock: SearchHeroesOperationProtocol {
    
    /// Loads the heroes
    ///
    /// - Parameter name: The name of the hero
    /// - Returns: A list with the heroes
    /// - Throws: Exception
    func perform(name: String) throws -> [Hero] {
        performIsCalled = true
        if internetConnectionAvailable {
            return heroes
        } else {
            throw ConnectivityException()
        }
    }
}
