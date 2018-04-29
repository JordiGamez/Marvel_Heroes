import Foundation

/// Presenter for the hero detail view
class HeroDetailPresenter {
    
    // MARK: - Constants
    
    let tag = String(describing: HeroDetailPresenter.self)
    let loadHeroDetailUseCase: LoadHeroDetailUseCase?
    
    // MARK: - Variables
    
    var view: HeroDetailViewProtocol?
    var networkProvider: NetworkProvider
    var numberOfHeroes = 0
    
    // MARK: - Initializers
    
    init(loadHeroDetailUseCase: LoadHeroDetailUseCase, networkProvider: NetworkProvider) {
        self.loadHeroDetailUseCase = loadHeroDetailUseCase
        self.networkProvider = networkProvider
    }
}

// MARK: - HeroDetailPresenterProtocol protocol conformance

extension HeroDetailPresenter: HeroDetailPresenterProtocol {
    
    /// Bind the presenter and the view
    ///
    /// - Parameter view: A HeroDetailViewProtocol conformance object
    func bind(view: HeroDetailViewProtocol) {
        self.view = view
    }
    
    /// Load hero details
    ///
    /// - Parameter heroId: The hero id
    func loadHeroDetail(heroId: String) {
        loadHeroDetailUseCase?.execute(callback: LoadHeroDetailCallback(parent: self), params: LoadHeroDetailParams(id: heroId))
    }
}

// MARK: - Callback for LoadHeroDetailUseCase

extension HeroDetailPresenter {
    
    class LoadHeroDetailCallback: Callback<LoadHeroDetailResult> {
        
        var parent: HeroDetailPresenter
        
        init(parent: HeroDetailPresenter) {
            self.parent = parent
        }
        
        // Correct result
        override func onResult(result: LoadHeroDetailResult) {
            self.parent.view?.showHero(hero: result.hero!)
        }
        
        // Connectivity error
        override func onConnectivityError(exception: ConnectivityException) {
            
        }
        
        // Error
        override func onGenericError(exception: Exception) {
            
        }
    }
}
