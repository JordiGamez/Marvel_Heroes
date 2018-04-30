import Foundation

/// Presenter for the heroes collection view
class HeroesCollectionPresenter {
    
    // MARK: - Constants
    
    let tag = String(describing: HeroesCollectionPresenter.self)
    let loadHeroesUseCase: LoadHeroesUseCase?
    let searchHeroUseCase: SearchHeroUseCase?
    
    // MARK: - Variables
    
    var view: HeroesCollectionViewProtocol?
    var networkProvider: NetworkProvider
    var numberOfHeroes = 0
    
    // MARK: - Initializers
    
    init(loadHeroesUseCase: LoadHeroesUseCase, searchHeroUseCase: SearchHeroUseCase, networkProvider: NetworkProvider) {
        self.loadHeroesUseCase = loadHeroesUseCase
        self.searchHeroUseCase = searchHeroUseCase
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
        if !networkProvider.deviceHasInternetConnection() && numberOfHeroes == 0 {
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
    
    /// Detect when the search button is clicked
    func searchButtonClicked() {
        self.view?.hideKeyboard()
    }
    
    /// Search hero by name
    ///
    /// - Parameter name: The hero name
    func searchHeroName(name: String) {
        if name == "" {
            self.view?.hideKeyboard()
            numberOfHeroes = 0
            loadHeroes()
        } else {
            searchHeroUseCase?.execute(callback: SearchHeroCallback(parent: self), params: SearchHeroParams(name: name))
        }
    }
}

// MARK: - Callback for LoadHeroesUseCase

extension HeroesCollectionPresenter {
    
    class LoadHeroesCallback: Callback<LoadHeroesResult> {
        
        var parent: HeroesCollectionPresenter
        
        init(parent: HeroesCollectionPresenter) {
            self.parent = parent
        }
        
        // Correct result
        override func onResult(result: LoadHeroesResult) {
            self.parent.view?.hideError()
            self.parent.view?.hideErrorLoadingMore()
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
        
        // Connectivity error
        override func onConnectivityError(exception: ConnectivityException) {
            self.parent.view?.hideLoading()
            if parent.numberOfHeroes == 0 {
                self.parent.view?.showError()
            } else {
                self.parent.view?.showErrorLoadingMore()
            }
        }
        
        // Error
        override func onGenericError(exception: Exception) {
            self.parent.view?.hideLoading()
            if parent.numberOfHeroes == 0 {
                self.parent.view?.showError()
            } else {
                self.parent.view?.showErrorLoadingMore()
            }
        }
    }
}

// MARK: - Callback for SearchHeroUseCase

extension HeroesCollectionPresenter {
    
    class SearchHeroCallback: Callback<SearchHeroResult> {
        
        var parent: HeroesCollectionPresenter
        
        init(parent: HeroesCollectionPresenter) {
            self.parent = parent
        }
        
        // Correct result
        override func onResult(result: SearchHeroResult) {
            if let heroList = result.hero {
                self.parent.view?.showHeroes(list: heroList)
                self.parent.view?.showHeroCollectionList()
            }
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
