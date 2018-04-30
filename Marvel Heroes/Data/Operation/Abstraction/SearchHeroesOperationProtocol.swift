import Foundation

/// Abstraction for loading the search heroes operation
protocol SearchHeroesOperationProtocol {
    
    /// Loads the heroes
    ///
    /// - Parameter name: The name of the hero
    /// - Returns: A list with the heroes
    /// - Throws: Exception
    func perform(name: String) throws -> [Hero]
}
