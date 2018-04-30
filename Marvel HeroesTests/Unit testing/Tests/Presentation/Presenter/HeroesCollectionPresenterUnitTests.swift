import XCTest
@testable import Marvel_Heroes

/// HeroesCollectionPresenter unit testing
class HeroesCollectionPresenterUnitTests: XCTestCase {
    
    // MARK: - Constants
    
    let zeroNumberOfHeroesVisible = 0
    let moreThanZeroHeroesVisible = 40
    let emptyHeroName = ""
    
    // MARK: - Variables
    
    private var presenter: HeroesCollectionPresenter?
    private var loadHeroesUseCase: LoadHeroesUseCase?
    private var searchHeroUseCase: SearchHeroUseCase?
    private var getHeroesOperation: GetHeroesOperationMock?
    private var searchHeroesOperation: SearchHeroesOperationMock?
    private var client = ApiClientMock()
    private var view: HeroesCollectionViewControllerMock?
    
    // MARK: - Set up
    
    override func setUp() {
        getHeroesOperation = GetHeroesOperationMock(client: client)
        searchHeroesOperation = SearchHeroesOperationMock(client: client)
        loadHeroesUseCase = LoadHeroesUseCase(doInBackground: false, operation: getHeroesOperation!)
        searchHeroUseCase = SearchHeroUseCase(doInBackground: false, operation: searchHeroesOperation!)
        presenter = HeroesCollectionPresenter(loadHeroesUseCase: loadHeroesUseCase!, searchHeroUseCase: searchHeroUseCase!, networkProvider: NetworkProvider())
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
    
    // MARK: searchButtonClicked()
    
    func testWhenSearchButtonClicked_ThenKeyboardIsDismissed() {
        presenter?.searchButtonClicked()
        
        XCTAssertTrue((view?.hideKeyboardIsCalled)!)
    }
    
    // MARK: searchHeroName() when hero name is empty
    
    func testGivenEmptyHeroName_WhenSearchHero_ThenDismissIsCalledAndHomeListIsLoaded() {
        presenter?.searchHeroName(name: emptyHeroName)
        
        XCTAssertTrue((view?.hideKeyboardIsCalled)!)
        XCTAssertTrue((view?.showLoadingIsCalled)!)
    }
}
