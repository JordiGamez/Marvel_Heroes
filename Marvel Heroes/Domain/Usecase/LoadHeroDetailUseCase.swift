import Foundation

/// Use case to load all hero details
class LoadHeroDetailUseCase: BaseUseCase<LoadHeroDetailResult, LoadHeroDetailParams> {
    
    // MARK: - Variables
    
    var operation: GetHeroDetailOperationProtocol
    
    // MARK: - Initializer
    
    init(doInBackground: Bool = false, operation: GetHeroDetailOperationProtocol) {
        self.operation = operation
        super.init(doInBackground: doInBackground)
    }
    
    // MARK: - Methods
    
    /// Executes the use case
    ///
    /// - Parameter params: Param class to execute LoadHeroDetailUseCase
    override func execute(params: LoadHeroDetailParams) {
        do {
            let result = try operation.perform(heroId: params.id)
            let loadHeroesResult = LoadHeroDetailResult()
            loadHeroesResult.hero = result
            onResult(result: loadHeroesResult)
        } catch let exception as ConnectivityException {
            onConnectivityError(exception: exception)
        } catch let exception {
            onGenericError(exception: exception as! Exception)
        }
    }
}
