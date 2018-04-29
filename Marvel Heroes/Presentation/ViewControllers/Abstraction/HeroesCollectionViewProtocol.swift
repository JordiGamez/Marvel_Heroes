import Foundation

/// Abstraction for the heroes collection view
protocol HeroesCollectionViewProtocol {
    
    /// Displays a list of heroes
    ///
    /// - Parameter list: An array containing the heroes
    func showHeroes(list: [Hero])
    
    /// Displays a loader
    func showLoading()
    
    /// Hides the loader
    func hideLoading()
    
    /// Displays the collection list
    func showHeroCollectionList()
}
