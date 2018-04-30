import Foundation

/// Presenter for the hero detail view
class HeroDetailPresenter {
    
    // MARK: - Constants
    
    let tag = String(describing: HeroDetailPresenter.self)
    let loadHeroDetailUseCase: LoadHeroDetailUseCase?
    let loadHeroDetailComicsUseCase: LoadHeroDetailComicsUseCase?
    
    // MARK: - Variables
    
    var view: HeroDetailViewProtocol?
    var networkProvider: NetworkProvider
    var numberOfHeroes = 0
    
    // MARK: - Initializers
    
    init(loadHeroDetailUseCase: LoadHeroDetailUseCase, loadHeroDetailComicsUseCase: LoadHeroDetailComicsUseCase, networkProvider: NetworkProvider) {
        self.loadHeroDetailUseCase = loadHeroDetailUseCase
        self.loadHeroDetailComicsUseCase = loadHeroDetailComicsUseCase
        self.networkProvider = networkProvider
    }
    
    /// Load hero comics
    ///
    /// - Parameter heroId: The hero id
    func loadHeroComics(heroId: String) {
        loadHeroDetailComicsUseCase?.execute(callback: LoadHeroDetailComicsCallback(parent: self), params: LoadHeroDetailComicsParams(id: heroId))
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
    
    /// Shows/hides comics container
    ///
    /// - Parameter numberOfComics: The number of comics
    func displayComicsContainer(numberOfComics: Int) {
        if numberOfComics == 0 {
            self.view?.hideComicsHeader()
            self.view?.hideComicsCollection()
        } else {
            self.view?.showComicsHeader()
            self.view?.showComicsCollection()
        }
        
        self.view?.hideLoading()
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
            self.parent.view?.showLoading()
            self.parent.loadHeroComics(heroId: (result.hero?.id)!)
        }
        
        // Connectivity error
        override func onConnectivityError(exception: ConnectivityException) {
            print("\(self.parent.tag): onConnectivityError")
        }
        
        // Error
        override func onGenericError(exception: Exception) {
            print("\(self.parent.tag): onGenericError")
        }
    }
}

// MARK: - Callback for LoadHeroDetailComicsUseCase

extension HeroDetailPresenter {
    
    class LoadHeroDetailComicsCallback: Callback<LoadHeroDetailComicsResult> {
        
        var parent: HeroDetailPresenter
        
        init(parent: HeroDetailPresenter) {
            self.parent = parent
        }
        
        // Correct result
        override func onResult(result: LoadHeroDetailComicsResult) {
            self.parent.view?.showComics(comicList: result.comic!)
        }
        
        // Connectivity error
        override func onConnectivityError(exception: ConnectivityException) {
            print("\(self.parent.tag): onConnectivityError")
        }
        
        // Error
        override func onGenericError(exception: Exception) {
            print("\(self.parent.tag): onGenericError")
        }
    }
}
