import Foundation

/// Operation to load the heroes comics
class GetHeroDetailComicsOperation {
    
    // MARK: - Variables
    
    var client: ApiClientProtocol
    
    // MARK: - Initializers
    
    init(client: ApiClientProtocol) {
        self.client = client
    }
}

// MARK: - GetHeroDetailComicsOperationProtocol protocol conformance

extension GetHeroDetailComicsOperation: GetHeroDetailComicsOperationProtocol {

    /// Loads the heroes comics
    ///
    /// - Returns: 
    /// - Throws: Exception
    func perform(heroId: String) throws -> [Comic] {
        do {
            let result = try client.getComicDetails(heroId: heroId)
            let comicDetailMapper = ComicDetailMapper()
            return comicDetailMapper.transform(result!)
        } catch let exception as ConnectivityException {
            throw exception
        }
    }
}
