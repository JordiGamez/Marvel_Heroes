import Foundation

class HeroesCollectionPresenterMock {
    
    // MARK: - Constants
    
    let loadHeroesUseCase: LoadHeroesUseCase?
    
    // MARK: - Variables
    
    var bindIsCalled = false
    var loadHeroesIsCalled = false
    var networkProvider: NetworkProvider
    
    // MARK: - Initializers
    
    init(loadHeroesUseCase: LoadHeroesUseCase, networkProvider: NetworkProvider) {
        self.loadHeroesUseCase = loadHeroesUseCase
        self.networkProvider = networkProvider
    }
}

// MARK: - HeroesCollectionPresenterProtocol protocol conformance

extension HeroesCollectionPresenterMock: HeroesCollectionPresenterProtocol {
    
    /// Bind the presenter and the view
    ///
    /// - Parameter view: A HeroesCollectionViewProtocol conformance object
    func bind(view: HeroesCollectionViewProtocol) {
        bindIsCalled = true
    }
    
    /// Load heroes
    func loadHeroes() {
        loadHeroesIsCalled = true
    }
}
