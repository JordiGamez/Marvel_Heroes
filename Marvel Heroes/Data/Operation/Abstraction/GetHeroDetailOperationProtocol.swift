import Foundation

/// Abstraction for loading the heroes operation
protocol GetHeroDetailOperationProtocol {
    
    /// Loads the heroes
    ///
    /// - Parameter offset: Skip the specified number of resources in the result set
    /// - Returns: A list with the heroes
    /// - Throws: Exception
    func perform(heroId: String) throws -> Hero
}
