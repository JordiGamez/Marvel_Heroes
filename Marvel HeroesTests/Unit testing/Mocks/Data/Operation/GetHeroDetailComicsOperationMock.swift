import Foundation

/// Operation to load the heroes comics
class GetHeroDetailComicsOperationMock {
    
    // MARK: - Variables
    
    var client: ApiClientProtocol
    var internetConnectionAvailable = true
    var comics: [Comic] = []
    var performIsCalled = false
    
    // MARK: - Initializers
    
    init(client: ApiClientProtocol) {
        self.client = client
    }
}

// MARK: - GetHeroDetailComicsOperationProtocol protocol conformance

extension GetHeroDetailComicsOperationMock: GetHeroDetailComicsOperationProtocol {
    
    /// Loads the heroes comics
    ///
    /// - Parameter heroId: The id of the hero
    /// - Returns: The array of the comics
    /// - Throws: Exception
    func perform(heroId: String) throws -> [Comic] {
        performIsCalled = true
        if internetConnectionAvailable {
            return comics
        } else {
            throw ConnectivityException()
        }
    }
}
