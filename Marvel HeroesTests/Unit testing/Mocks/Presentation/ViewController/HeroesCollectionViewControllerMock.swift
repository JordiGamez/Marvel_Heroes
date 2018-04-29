import Foundation

/// HeroesCollectionViewController mock
class HeroesCollectionViewControllerMock {
    
    // MARK: - Variables
    
    var showHeroesIsCalled = false
    var addHeroesIsCalled = false
    var showLoadingIsCalled = false
    var hideLoadingIsCalled = false
    var showHeroCollectionListIsCalled = false
    var showErrorIsCalled = false
    var hideErrorIsCalled = false
    var showErrorLoadingMoreIsCalled = false
    var hideErrorLoadingMoreIsCalled = false
}

// MARK: - HeroesCollectionViewProtocol protocol conformance

extension HeroesCollectionViewControllerMock: HeroesCollectionViewProtocol {
    
    /// Displays a list of heroes
    ///
    /// - Parameter list: An array containing the heroes
    func showHeroes(list: [Hero]) {
        showHeroesIsCalled = true
    }
    
    /// Add a list of heroes to the current list
    ///
    /// - Parameter list: An array containing the new heroes
    func addHeroes(list: [Hero]) {
        addHeroesIsCalled = true
    }
    
    /// Displays a loader
    func showLoading() {
        showLoadingIsCalled = true
    }
    
    /// Hides the loader
    func hideLoading() {
        hideLoadingIsCalled = true
    }
    
    /// Displays the collection list
    func showHeroCollectionList() {
        showHeroCollectionListIsCalled = true
    }
    
    /// Displays an error if something went wrong
    func showError() {
        showErrorIsCalled = true
    }
    
    /// Hides the error view
    func hideError() {
        hideErrorIsCalled = true
    }
    
    /// Displays an error if something went wrong when loading more items
    func showErrorLoadingMore() {
        showErrorLoadingMoreIsCalled = true
    }
    
    /// Hides the error view
    func hideErrorLoadingMore() {
        hideErrorLoadingMoreIsCalled = true
    }
}
