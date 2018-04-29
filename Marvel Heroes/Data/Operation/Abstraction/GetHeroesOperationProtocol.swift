import Foundation

/// Abstraction for loading the heroes operation
protocol GetHeroesOperationProtocol {
    
    /// Loads the heroes
    ///
    /// - Parameter offset: Skip the specified number of resources in the result set
    /// - Returns: A list with the heroes
    /// - Throws: Exception
    func perform(offset: Int) throws -> [Hero]
}
