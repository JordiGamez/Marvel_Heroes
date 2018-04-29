import Foundation

/// Abstraction for HeroDetailPresenter
protocol HeroDetailPresenterProtocol {
    
    /// Bind the presenter and the view
    ///
    /// - Parameter view: A HeroDetailViewProtocol conformance object
    func bind(view: HeroDetailViewProtocol)
    
    /// Load hero details
    ///
    /// - Parameter heroId: The hero id
    func loadHeroDetail(heroId: String)
    
    /// Shows/hides comics container
    ///
    /// - Parameter numberOfComics: The number of comics
    func displayComicsContainer(numberOfComics: Int)
}
