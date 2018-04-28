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
    
    // MARK: - Constants
    
    let collectionViewCellIdentifier = "HeroesCollectionCell"
    
    // MARK: - Variables
    
    var heroesCollectionPresenter: HeroesCollectionPresenter?
    var presenter: HeroesCollectionPresenterProtocol?
    var heroes: [Hero] = []
    
    // MARK: - Initializers
    
    init(_ coder: NSCoder? = nil) {
        
        heroesCollectionPresenter = HeroesCollectionPresenter(loadHeroesUseCase: LoadHeroesUseCase(doInBackground: true, operation: GetHeroesOperation(client: ApiClient())))
        
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
        
        customView.heroCollectionView.dataSource = self
        customView.heroCollectionView.delegate = self
        
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
    
    /// Displays a list of heroes
    ///
    /// - Parameter list: An array containing the heroes
    func showHeroes(list: [Hero]) {
        heroes = list
        customView.heroCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource and UICollectionViewDelegate protocol conformance

extension HeroesCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = customView.heroCollectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellIdentifier, for: indexPath) as! HeroesCollectionViewCell
        
        cell.displayContent(image: heroes[indexPath.row].image!, name: heroes[indexPath.row].name!)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout protocol conformance

extension HeroesCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/2
        let yourHeight = yourWidth
        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
