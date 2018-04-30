import Foundation

/// Use case to search heroes
class SearchHeroUseCase: BaseUseCase<SearchHeroResult, SearchHeroParams> {
    
    // MARK: - Variables
    
    var operation: SearchHeroesOperationProtocol
    
    // MARK: - Initializer
    
    init(doInBackground: Bool = false, operation: SearchHeroesOperationProtocol) {
        self.operation = operation
        super.init(doInBackground: doInBackground)
    }
    
    // MARK: - Methods
    
    /// Executes the use case
    ///
    /// - Parameter params: Param class to execute SearchHeroUseCase
    override func execute(params: SearchHeroParams) {
        do {
            let result = try operation.perform(name: params.name)
            let loadHeroesResult = SearchHeroResult()
            loadHeroesResult.hero = result
            onResult(result: loadHeroesResult)
        } catch let exception as ConnectivityException {
            onConnectivityError(exception: exception)
        } catch let exception {
            onGenericError(exception: exception as! Exception)
        }
    }
}
