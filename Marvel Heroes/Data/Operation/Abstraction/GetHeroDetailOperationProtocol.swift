import Foundation

/// Abstraction for loading the heroes detail operation
protocol GetHeroDetailOperationProtocol {
    
    /// Loads the hero information
    ///
    /// - Parameter heroId: The id of the hero
    /// - Returns: A list with the hero information
    /// - Throws: Exception
    func perform(heroId: String) throws -> Hero
}
