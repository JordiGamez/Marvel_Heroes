import Foundation

/// Presenter for the heroes collection view
class HeroesCollectionPresenter {
    
    // MARK: - Constants
    
    let tag = String(describing: HeroesCollectionPresenter.self)
    let loadHeroesUseCase: LoadHeroesUseCase?
    
    // MARK: - Variables
    
    var view: HeroesCollectionViewProtocol?
    var networkProvider: NetworkProvider
    var numberOfHeroes = 0
    
    // MARK: - Initializers
    
    init(loadHeroesUseCase: LoadHeroesUseCase, networkProvider: NetworkProvider) {
        self.loadHeroesUseCase = loadHeroesUseCase
        self.networkProvider = networkProvider
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
        if !networkProvider.deviceHasInternetConnection() {
            self.view?.hideLoading()
            self.view?.showError()
            return
        }
        
        // If it is initial load heroes call
        if numberOfHeroes == 0 {
            self.view?.showLoading()
        }
        
        loadHeroesUseCase?.execute(callback: LoadHeroesCallback(parent: self), params: LoadHeroesParams(offset: numberOfHeroes))
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
                if self.parent.numberOfHeroes == 0 {
                    self.parent.view?.showHeroes(list: heroList)
                    self.parent.view?.showHeroCollectionList()
                } else {
                    self.parent.view?.addHeroes(list: heroList)
                }
                
                self.parent.numberOfHeroes += heroList.count
            }
        }
    }
}
