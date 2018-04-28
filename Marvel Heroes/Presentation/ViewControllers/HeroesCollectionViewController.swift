//
//  HeroesCollectionViewController.swift
//  Marvel Heroes
//
//  Created by Jordi Gamez on 28/4/18.
//  Copyright © 2018 Jordi Gamez. All rights reserved.
//

import UIKit

class HeroesCollectionViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var customView: HeroesCollectionView!
    
    // MARK: - Variables
    
    var heroesCollectionPresenter: HeroesCollectionPresenter?
    var presenter: HeroesCollectionPresenterProtocol?
    
    // MARK: - Initializers
    
    init(_ coder: NSCoder? = nil) {
        
        heroesCollectionPresenter = HeroesCollectionPresenter(loadHeroesUseCase: LoadHeroesUseCase(doInBackground: true, operation: GetHeroesOperation(dataSource: ApiClient())))
        
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
        
        // Load the presenter
        loadPresenter(presenter: heroesCollectionPresenter!)
        
        // Bind the presenter with the view
        presenter?.bind(view: self)
        
        // Load heroes
        presenter?.loadHeroes()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Methods
    
    /// Sets the presenter
    ///
    /// - Parameter presenter: A HeroesCollectionPresenterProtocol conformance object
    func loadPresenter(presenter: HeroesCollectionPresenterProtocol) {
        self.presenter = presenter
    }
}

// MARK: - HeroesCollectionViewProtocol protocol conformance

extension HeroesCollectionViewController: HeroesCollectionViewProtocol {
    
    func showHeroes(list: [Hero]) {
        for hero in list {
            print(hero.name)
        }
    }
}
