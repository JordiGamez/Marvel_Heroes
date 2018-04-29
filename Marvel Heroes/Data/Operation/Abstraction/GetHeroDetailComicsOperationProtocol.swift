import Foundation

/// Abstraction for loading the heroes comics operation
protocol GetHeroDetailComicsOperationProtocol {
    
    /// Loads the heroes comics
    ///
    /// - Returns:
    /// - Throws: Exception
    func perform(heroId: String) throws -> [Comic]
}
