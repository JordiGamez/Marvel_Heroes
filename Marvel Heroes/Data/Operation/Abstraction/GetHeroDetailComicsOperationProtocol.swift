import Foundation

/// Abstraction for loading the heroes comics operation
protocol GetHeroDetailComicsOperationProtocol {
    
    /// Loads the heroes comics
    ///
    /// - Parameter heroId: The id of the hero
    /// - Returns: The array of the comics
    /// - Throws: Exception
    func perform(heroId: String) throws -> [Comic]
}
