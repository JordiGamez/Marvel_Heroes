import Foundation

/// Abstraction for the hero detail view
protocol HeroDetailViewProtocol {
    
    /// Show the hero information
    ///
    /// - Parameter showHero: The hero object
    func showHero(hero: Hero)
    
    /// Show the hero comics information
    ///
    /// - Parameter comicList: The hero comics
    func showComics(comicList: [Comic])
    
    /// Display the comics header
    func showComicsHeader()
    
    /// Hide the comics header
    func hideComicsHeader()
    
    /// Display the comics collection
    func showComicsCollection()
    
    /// Hide the comics collection
    func hideComicsCollection()
    
    /// Displays a loader
    func showLoading()
    
    /// Hides the loader
    func hideLoading()
}
