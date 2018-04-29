import XCTest
@testable import Marvel_Heroes

/// LoadHeroesUseCase unit testing
class LoadHeroesUseCaseUnitTests: XCTestCase {
    
    // MARK: - Constants
    
    let doInBackground = false
    let timeoutExpectation = 5.0
    
    // MARK: - Variables
    
    private var useCase: LoadHeroesUseCase?
    private var operation: GetHeroesOperationMock?
    private var client = ApiClientMock()
    private var testExpectation: XCTestExpectation?
    private var performIsCalled = false
    private var onResult = false
    private var onConnectivityError = false
    private var offset = 0
    
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
        operation = GetHeroesOperationMock(client: client)
        operation?.internetConnectionAvailable = true
        useCase = LoadHeroesUseCase(doInBackground: doInBackground, operation: operation!)
        
        useCase?.execute(callback: LoadHeroesCallback(parent: self), params: LoadHeroesParams(offset: offset))
        
        testExpectation = expectation(description: "")
        waitForExpectations(timeout: timeoutExpectation)
        
        XCTAssertTrue(performIsCalled)
        XCTAssertTrue(onResult)
    }
    
    // MARK: execute() onConnectivityError()
    
    func testGivenDisabledInternetConnect_WhenExecuteUseCase_ThenOnConnectivityErrorIsCalled() {
        operation = GetHeroesOperationMock(client: client)
        operation?.internetConnectionAvailable = false
        useCase = LoadHeroesUseCase(doInBackground: doInBackground, operation: operation!)
        
        useCase?.execute(callback: LoadHeroesCallback(parent: self), params: LoadHeroesParams(offset: offset))
        
        testExpectation = expectation(description: "")
        waitForExpectations(timeout: timeoutExpectation)
        
        XCTAssertTrue(performIsCalled)
        XCTAssertTrue(onConnectivityError)
    }
}

// MARK: - Callback for LoadHeroesUseCase

extension LoadHeroesUseCaseUnitTests {
    
    class LoadHeroesCallback: Callback<LoadHeroesResult> {
        
        var parent: LoadHeroesUseCaseUnitTests
        
        init(parent: LoadHeroesUseCaseUnitTests) {
            self.parent = parent
        }
        
        // Correct result
        override func onResult(result: LoadHeroesResult) {
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
