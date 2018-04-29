/// Mock for communication with the Marvel API
class ApiClientMock {
    
}

// MARK: - ApiClientProtocol protocol conformance

extension ApiClientMock: ApiClientProtocol {
    
    /// Gets the heroes from the Api
    ///
    /// - Parameter offset: Skip the specified number of resources in the result set
    /// - Returns: A HeroEntity object
    /// - Throws: Exception
    func getHeroes(offset: Int = 0) throws -> HeroEntity? {
        return nil
    }
}
