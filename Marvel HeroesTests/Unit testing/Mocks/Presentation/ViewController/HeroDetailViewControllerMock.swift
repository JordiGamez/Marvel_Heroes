import Foundation

/// HeroDetailViewController mock
class HeroDetailViewControllerMock {
    
    // MARK: - Variables
    
    var showHeroIsCalled = false
    var showComicsIsCalled = false
    var showComicsHeaderIsCalled = false
    var hideComicsHeaderIsCalled = false
    var showComicsCollectionIsCalled = false
    var hideComicsCollectionIsCalled = false
    var showLoadingIsCalled = false
    var hideLoadingIsCalled = false
}

extension HeroDetailViewControllerMock: HeroDetailViewProtocol {
    
    /// Show the hero information
    ///
    /// - Parameter showHero: The hero object
    func showHero(hero: Hero) {
        showHeroIsCalled = true
    }
    
    /// Show the hero comics information
    ///
    /// - Parameter comicList: The hero comics
    func showComics(comicList: [Comic]) {
        showComicsIsCalled = true
    }
    
    /// Display the comics header
    func showComicsHeader() {
        showComicsHeaderIsCalled = true
    }
    
    /// Hide the comics header
    func hideComicsHeader() {
        hideComicsHeaderIsCalled = true
    }
    
    /// Display the comics collection
    func showComicsCollection() {
        showComicsCollectionIsCalled = true
    }
    
    /// Hide the comics collection
    func hideComicsCollection() {
        hideComicsCollectionIsCalled = true
    }
    
    /// Displays a loader
    func showLoading() {
        showLoadingIsCalled = true
    }
    
    /// Hides the loader
    func hideLoading() {
        hideLoadingIsCalled = true
    }
}
