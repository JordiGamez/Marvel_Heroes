import Foundation

/// Use case to load heroes comics
class LoadHeroDetailComicsUseCase: BaseUseCase<LoadHeroDetailComicsResult, LoadHeroDetailComicsParams> {
    
    // MARK: - Variables
    
    var operation: GetHeroDetailComicsOperationProtocol
    
    // MARK: - Initializer
    
    init(doInBackground: Bool = false, operation: GetHeroDetailComicsOperationProtocol) {
        self.operation = operation
        super.init(doInBackground: doInBackground)
    }
    
    // MARK: - Methods
    
    /// Executes the use case
    ///
    /// - Parameter params: Param class to execute LoadHeroDetailComicsUseCase
    override func execute(params: LoadHeroDetailComicsParams) {
        do {
            let result = try operation.perform(heroId: params.id)
            let loadHeroesDetailComicsResult = LoadHeroDetailComicsResult()
            loadHeroesDetailComicsResult.comic = result
            onResult(result: loadHeroesDetailComicsResult)
        } catch let exception as ConnectivityException {
            onConnectivityError(exception: exception)
        } catch let exception {
            onGenericError(exception: exception as! Exception)
        }
    }
}
