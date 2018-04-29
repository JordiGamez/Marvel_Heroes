import XCTest
@testable import Marvel_Heroes

/// HeroesCollectionPresenter unit testing
class HeroesCollectionPresenterUnitTests: XCTestCase {
    
    // MARK: - Constants
    
    let zeroNumberOfHeroesVisible = 0
    let moreThanZeroHeroesVisible = 40
    
    // MARK: - Variables
    
    private var presenter: HeroesCollectionPresenter?
    private var useCase: LoadHeroesUseCase?
    private var operation: GetHeroesOperationMock?
    private var client = ApiClientMock()
    private var view: HeroesCollectionViewControllerMock?
    
    // MARK: - Set up
    
    override func setUp() {
        operation = GetHeroesOperationMock(client: client)
        useCase = LoadHeroesUseCase(doInBackground: false, operation: operation!)
        presenter = HeroesCollectionPresenter(loadHeroesUseCase: useCase!, networkProvider: NetworkProvider())
        view = HeroesCollectionViewControllerMock()
        
        // Bind the view with the presenter
        presenter?.bind(view: view!)
        
        super.setUp()
    }
    
    // MARK: - Tests
    
    // MARK: loadHeroes() when zero heroes visible
    
    func testGivenZeroNumberOfHeroesVisible_WhenLoadHeroesIsCalled_ThenShowLoadingIsCalled() {
        presenter?.numberOfHeroes = zeroNumberOfHeroesVisible
        
        presenter?.loadHeroes()
        
        XCTAssertTrue((view?.showLoadingIsCalled)!)
    }
    
    // MARK: loadHeroes() when more than zero heroes visible
    
    func testGivenMoreThanZeroHeroesVisible_WhenLoadHeroesIsCalled_ThenShowLoadingIsNotCalled() {
        presenter?.numberOfHeroes = moreThanZeroHeroesVisible
        
        presenter?.loadHeroes()
        
        XCTAssertFalse((view?.showLoadingIsCalled)!)
    }
}
