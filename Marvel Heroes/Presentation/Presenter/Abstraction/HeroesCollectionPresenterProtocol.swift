import Foundation

/// Abstraction for HeroesCollectionPresenter
protocol HeroesCollectionPresenterProtocol {
    
    /// Bind the presenter and the view
    ///
    /// - Parameter view: A HeroesCollectionViewProtocol conformance object
    func bind(view: HeroesCollectionViewProtocol)
    
    /// Load heroes
    func loadHeroes()
}
