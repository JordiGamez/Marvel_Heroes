import Foundation

/// Use case to load heroes
class LoadHeroesUseCase: BaseUseCase<LoadHeroesResult, LoadHeroesParams> {
    
    // MARK: - Variables
    
    private var operation: GetHeroesOperationProtocol
    
    // MARK: - Initializer
    
    init(doInBackground: Bool = false, operation: GetHeroesOperationProtocol) {
        self.operation = operation
        super.init(doInBackground: doInBackground)
    }
    
    // MARK: - Methods
    
    /// Executes the use case
    ///
    /// - Parameter params: Param class to execute LoadHeroesUseCase
    override func execute(params: LoadHeroesParams) {
        do {
            let result = try operation.perform(offset: params.offset)
            let loadHeroesResult = LoadHeroesResult()
            loadHeroesResult.hero = result
            onResult(result: loadHeroesResult)
        } catch let exception {
            // TODO: Handle the exception
        }
    }
}
