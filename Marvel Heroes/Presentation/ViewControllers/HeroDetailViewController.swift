//
//  HeroDetailViewController.swift
//  Marvel Heroes
//
//  Created by Jordi Gamez on 29/4/18.
//  Copyright © 2018 Jordi Gamez. All rights reserved.
//

import UIKit
import Kingfisher

class HeroDetailViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var customView: HeroDetailView!
    
    // MARK: - Variables
    
    var heroDetailPresenter: HeroDetailPresenter?
    var presenter: HeroDetailPresenterProtocol?
    var heroId: String?
    var heroName: String?
    var heroImageUrl: String?
    
    // MARK: - Initializers
    
    init(_ coder: NSCoder? = nil) {
        heroDetailPresenter = HeroDetailPresenter(loadHeroDetailUseCase: LoadHeroDetailUseCase(doInBackground: true, operation: GetHeroDetailOperation(client: ApiClient())), networkProvider: NetworkProvider())
        
        if let coder = coder {
            super.init(coder: coder)!
        } else {
            super.init(nibName: nil, bundle: nil)
        }
    }
    
    required convenience init(coder: NSCoder) {
        self.init(coder)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Update the view with content
        updateView()
        
        // Load the presenter
        loadPresenter(presenter: heroDetailPresenter!)
        
        // Bind the presenter with the view
        presenter?.bind(view: self)
        
        // Load heroes
        presenter?.loadHeroDetail(heroId: heroId!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Methods
    
    /// Update the view with the information from the collection view
    func updateView() {
        customView.nameLabel.text = heroName
        customView.imageUIImageView.kf.setImage(with: URL(string: heroImageUrl!)!)
    }
    
    /// Sets the presenter
    ///
    /// - Parameter presenter: A HeroDetailPresenterProtocol conformance object
    func loadPresenter(presenter: HeroDetailPresenterProtocol) {
        self.presenter = presenter
    }
}

// MARK: - HeroDetailViewProtocol protocol conformance

extension HeroDetailViewController: HeroDetailViewProtocol {
    
    /// Show the hero information
    ///
    /// - Parameter showHero: The hero object
    func showHero(hero: Hero) {
        customView.descriptionLabel.text = hero.description
    }
}
