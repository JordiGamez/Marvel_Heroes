import Foundation

/// Abstraction for the heroes collection view
protocol HeroesCollectionViewProtocol {
    
    /// Displays a list of heroes
    ///
    /// - Parameter list: An array containing the heroes
    func showHeroes(list: [Hero])
    
    /// Add a list of heroes to the current list
    ///
    /// - Parameter list: An array containing the new heroes
    func addHeroes(list: [Hero])
    
    /// Displays a loader
    func showLoading()
    
    /// Hides the loader
    func hideLoading()
    
    /// Displays the collection list
    func showHeroCollectionList()
    
    /// Displays an error if something went wrong
    func showError()
    
    /// Hides the error view
    func hideError()
    
    /// Displays an error if something went wrong when loading more items
    func showErrorLoadingMore()
    
    /// Hides the error view when loading more items
    func hideErrorLoadingMore()
}
