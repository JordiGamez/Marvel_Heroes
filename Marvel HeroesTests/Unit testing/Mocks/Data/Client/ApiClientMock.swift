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
    func getHeroes(offset: Int) throws -> HeroEntity? {
        return nil
    }
    
    /// Gets all the available information of a hero
    ///
    /// - Parameter heroId: The hero id
    /// - Returns: A HeroDetailEntity object
    /// - Throws: Exception
    func getHeroDetail(heroId: String) throws -> HeroDetailEntity? {
        return nil
    }
    
    /// Gets all the available comic information of a hero
    ///
    /// - Parameter heroId: The hero id
    /// - Returns: A ComicDetailEntity object
    /// - Throws: Exception
    func getComicDetails(heroId: String) throws -> ComicDetailEntity? {
        return nil
    }
}
