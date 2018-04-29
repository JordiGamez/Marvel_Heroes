import XCTest
@testable import Marvel_Heroes

/// HeroDetailPresenterUnitTest unit testing
class HeroDetailPresenterUnitTests: XCTestCase {
    
    // MARK: - Constants
    
    let zeroComics = 0
    let someComics = 10
    
    // MARK: - Variables
    
    private var presenter: HeroDetailPresenter?
    private var loadHeroDetailUseCase: LoadHeroDetailUseCase?
    private var loadHeroDetailComicsUseCase: LoadHeroDetailComicsUseCase?
    private var getHeroDetailoperation: GetHeroDetailOperationMock?
    private var getHeroDetailComicsOperation: GetHeroDetailComicsOperationMock?
    private var client = ApiClientMock()
    private var view: HeroDetailViewControllerMock?
    
    // MARK: - Set up
    
    override func setUp() {
        getHeroDetailoperation = GetHeroDetailOperationMock(client: client)
        getHeroDetailComicsOperation = GetHeroDetailComicsOperationMock(client: client)
        
        loadHeroDetailUseCase = LoadHeroDetailUseCase(doInBackground: false, operation: getHeroDetailoperation!)
        loadHeroDetailComicsUseCase = LoadHeroDetailComicsUseCase(doInBackground: false, operation: getHeroDetailComicsOperation!)
        
        presenter = HeroDetailPresenter(loadHeroDetailUseCase: loadHeroDetailUseCase!, loadHeroDetailComicsUseCase: loadHeroDetailComicsUseCase!, networkProvider: NetworkProvider())
        view = HeroDetailViewControllerMock()
        
        // Bind the view with the presenter
        presenter?.bind(view: view!)
        
        super.setUp()
    }
    
    // MARK: - Tests
    
    // MARK: displayComicsContainer() when there are 0 comics
    
    func testGivenZeroComics_WhenDisplayComicsContainer_ThenHideComicComponentAndLoaderIsCalled() {
        presenter?.displayComicsContainer(numberOfComics: zeroComics)
        
        XCTAssertTrue((view?.hideComicsHeaderIsCalled)!)
        XCTAssertTrue((view?.hideComicsCollectionIsCalled)!)
        XCTAssertTrue((view?.hideLoadingIsCalled)!)
    }
    
    // MARK: displayComicsContainer() when there are more than 0 comics
    
    func testGivenSomeComics_WhenDisplayComicsContainer_ThenShowComicComponentAndLoaderIsCalled() {
        presenter?.displayComicsContainer(numberOfComics: someComics)
        
        XCTAssertTrue((view?.showComicsHeaderIsCalled)!)
        XCTAssertTrue((view?.showComicsCollectionIsCalled)!)
        XCTAssertTrue((view?.hideLoadingIsCalled)!)
    }
}
