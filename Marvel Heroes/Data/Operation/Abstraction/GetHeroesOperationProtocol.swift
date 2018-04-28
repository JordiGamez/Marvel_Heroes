import Foundation

/// Abstraction for loading the heroes operation
protocol GetHeroesOperationProtocol {
    
    /// Loads the heroes
    ///
    /// - Returns: A list with the heroes
    /// - Throws: Exception
    func perform() throws -> [Hero]
}
