import XCTest
@testable import Marvel_Heroes

/// LoadHeroesUseCase unit testing
class LoadHeroesUseCaseUnitTests: XCTestCase {
    
    // MARK: - Constants
    
    let zeroNumberOfHeroesVisible = 0
    let moreThanZeroHeroesVisible = 40
    
    // MARK: - Variables
    
    private var useCase: LoadHeroesUseCase?
    private var operation: GetHeroesOperationMock?
    private var client = ApiClient()
    
    // MARK: - Set up
    
    override func setUp() {
        operation = GetHeroesOperationMock(client: client)
        useCase = LoadHeroesUseCase(doInBackground: false, operation: operation!)
        
        super.setUp()
    }
    
    // MARK: - Tests
    
    // MARK:
    
    func testGiven_When_Then() {
        
        useCase?.execute(params: LoadHeroesParams(offset: 0))
    }
}
