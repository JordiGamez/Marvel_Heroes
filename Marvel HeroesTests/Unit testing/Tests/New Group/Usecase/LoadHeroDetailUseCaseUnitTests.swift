import XCTest
@testable import Marvel_Heroes

/// LoadHeroDetailUseCase unit testing
class LoadHeroDetailUseCaseUnitTests: XCTestCase {
    
    // MARK: - Constants
    
    let doInBackground = false
    let timeoutExpectation = 5.0
    
    // MARK: - Variables
    
    private var useCase: LoadHeroDetailUseCase?
    private var operation: GetHeroDetailOperationMock?
    private var client = ApiClientMock()
    private var testExpectation: XCTestExpectation?
    private var performIsCalled = false
    private var onResult = false
    private var onConnectivityError = false
    private var id = "1011334"
    
    // MARK: - Set up
    
    override func setUp() {
        performIsCalled = false
        onResult = false
        onConnectivityError = false
        
        super.setUp()
    }
    
    // MARK: - Tests
    
    // MARK: execute() onResult()
    
    func testGivenEnabledInternetConnect_WhenExecuteUseCase_ThenOnResultIsCalled() {
        operation = GetHeroDetailOperationMock(client: client)
        operation?.internetConnectionAvailable = true
        useCase = LoadHeroDetailUseCase(doInBackground: doInBackground, operation: operation!)
        
        useCase?.execute(callback: LoadHeroesCallback(parent: self), params: LoadHeroDetailParams(id: id))
        
        testExpectation = expectation(description: "")
        waitForExpectations(timeout: timeoutExpectation)
        
        XCTAssertTrue(performIsCalled)
        XCTAssertTrue(onResult)
    }
    
    // MARK: execute() onConnectivityError()
    
    func testGivenDisabledInternetConnect_WhenExecuteUseCase_ThenOnConnectivityErrorIsCalled() {
        operation = GetHeroDetailOperationMock(client: client)
        operation?.internetConnectionAvailable = false
        useCase = LoadHeroDetailUseCase(doInBackground: doInBackground, operation: operation!)
        
        useCase?.execute(callback: LoadHeroesCallback(parent: self), params: LoadHeroDetailParams(id: id))
        
        testExpectation = expectation(description: "")
        waitForExpectations(timeout: timeoutExpectation)
        
        XCTAssertTrue(performIsCalled)
        XCTAssertTrue(onConnectivityError)
    }
}

// MARK: - Callback for LoadHeroDetailUseCase

extension LoadHeroDetailUseCaseUnitTests {
    
    class LoadHeroesCallback: Callback<LoadHeroDetailResult> {
        
        var parent: LoadHeroDetailUseCaseUnitTests
        
        init(parent: LoadHeroDetailUseCaseUnitTests) {
            self.parent = parent
        }
        
        // Correct result
        override func onResult(result: LoadHeroDetailResult) {
            self.parent.performIsCalled = (self.parent.operation?.performIsCalled)!
            self.parent.onResult = true
            self.parent.testExpectation?.fulfill()
        }
        
        // Connectivity error
        override func onConnectivityError(exception: ConnectivityException) {
            self.parent.performIsCalled = (self.parent.operation?.performIsCalled)!
            self.parent.onConnectivityError = true
            self.parent.testExpectation?.fulfill()
        }
        
        // Error
        override func onGenericError(exception: Exception) {
            self.parent.performIsCalled = (self.parent.operation?.performIsCalled)!
            self.parent.testExpectation?.fulfill()
        }
    }
}
