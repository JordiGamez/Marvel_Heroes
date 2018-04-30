import XCTest
@testable import Marvel_Heroes

/// SearchHeroUseCase unit testing
class SearchHeroUseCaseUnitTests: XCTestCase {
    
    // MARK: - Constants
    
    let doInBackground = false
    let timeoutExpectation = 5.0
    
    // MARK: - Variables
    
    private var useCase: SearchHeroUseCase?
    private var operation: SearchHeroesOperationMock?
    private var client = ApiClientMock()
    private var testExpectation: XCTestExpectation?
    private var performIsCalled = false
    private var onResult = false
    private var onConnectivityError = false
    private var heroName = "Hulk"
    
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
        operation = SearchHeroesOperationMock(client: client)
        operation?.internetConnectionAvailable = true
        useCase = SearchHeroUseCase(doInBackground: doInBackground, operation: operation!)
        
        useCase?.execute(callback: SearchHeroesCallback(parent: self), params: SearchHeroParams(name: heroName))
        
        testExpectation = expectation(description: "")
        waitForExpectations(timeout: timeoutExpectation)
        
        XCTAssertTrue(performIsCalled)
        XCTAssertTrue(onResult)
    }
    
    // MARK: execute() onConnectivityError()
    
    func testGivenDisabledInternetConnect_WhenExecuteUseCase_ThenOnConnectivityErrorIsCalled() {
        operation = SearchHeroesOperationMock(client: client)
        operation?.internetConnectionAvailable = false
        useCase = SearchHeroUseCase(doInBackground: doInBackground, operation: operation!)
        
        useCase?.execute(callback: SearchHeroesCallback(parent: self), params: SearchHeroParams(name: heroName))
        
        testExpectation = expectation(description: "")
        waitForExpectations(timeout: timeoutExpectation)
        
        XCTAssertTrue(performIsCalled)
        XCTAssertTrue(onConnectivityError)
    }
}

// MARK: - Callback for LoadHeroDetailUseCase

extension SearchHeroUseCaseUnitTests {
    
    class SearchHeroesCallback: Callback<SearchHeroResult> {
        
        var parent: SearchHeroUseCaseUnitTests
        
        init(parent: SearchHeroUseCaseUnitTests) {
            self.parent = parent
        }
        
        // Correct result
        override func onResult(result: SearchHeroResult) {
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
