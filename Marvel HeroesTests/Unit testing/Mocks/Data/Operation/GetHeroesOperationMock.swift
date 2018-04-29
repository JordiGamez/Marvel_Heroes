import Foundation

/// Operation to load the heroes mock
class GetHeroesOperationMock {
    
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

// MARK: - GetHeroesOperationProtocol protocol conformance

extension GetHeroesOperationMock: GetHeroesOperationProtocol {
    
    /// Loads the heroes
    ///
    /// - Returns: An array with the list of
    /// - Throws: Exception
    func perform(offset: Int = 0) throws -> [Hero] {
        performIsCalled = true
        if internetConnectionAvailable {
            return heroes
        } else {
            throw ConnectivityException()
        }
    }
}
