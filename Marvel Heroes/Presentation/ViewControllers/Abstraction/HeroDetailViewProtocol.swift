import Foundation

/// Abstraction for the hero detail view
protocol HeroDetailViewProtocol {
    
    /// Show the hero information
    ///
    /// - Parameter showHero: The hero object
    func showHero(hero: Hero)
}
