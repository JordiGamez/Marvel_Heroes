import Foundation

/// Presenter for the heroes collection view
class HeroesCollectionPresenter {
    
    // MARK: - Constants
    
    let tag = String(describing: HeroesCollectionPresenter.self)
    let loadHeroesUseCase: LoadHeroesUseCase?
    
    // MARK: - Variables
    
    var view: HeroesCollectionViewProtocol?
    
    // MARK: - Initializers
    
    init(loadHeroesUseCase: LoadHeroesUseCase) {
        self.loadHeroesUseCase = loadHeroesUseCase
    }
}

// MARK: - HeroesCollectionPresenterProtocol protocol conformance

extension HeroesCollectionPresenter: HeroesCollectionPresenterProtocol {
    
    /// Bind the presenter and the view
    ///
    /// - Parameter view: A HeroesCollectionViewProtocol conformance object
    func bind(view: HeroesCollectionViewProtocol) {
        self.view = view
    }
    
    /// Load heroes
    func loadHeroes() {
        self.view?.showLoading()
        
        loadHeroesUseCase?.execute(callback: LoadHeroesCallback(parent: self), params: LoadHeroesParams())
    }
}

// MARK: - Callback for LoadHeroesUseCase

extension HeroesCollectionPresenter {
    
    class LoadHeroesCallback: Callback<LoadHeroesResult> {
        
        var parent: HeroesCollectionPresenter
        
        init(parent: HeroesCollectionPresenter) {
            self.parent = parent
        }
        
        override func onResult(result: LoadHeroesResult) {
            self.parent.view?.hideLoading()
            if let heroList = result.hero {
                self.parent.view?.showHeroes(list: heroList)
                self.parent.view?.showHeroCollectionList()
            }
        }
    }
}
