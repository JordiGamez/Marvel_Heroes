//
//  HeroDetailViewController.swift
//  Marvel Heroes
//
//  Created by Jordi Gamez on 29/4/18.
//  Copyright © 2018 Jordi Gamez. All rights reserved.
//

import UIKit

class HeroDetailViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var customView: HeroDetailView!
    
    // MARK: - Constants
    
    let collectionViewCellIdentifier = "ComicsCollectionCell"
    
    // MARK: - Variables
    
    var heroDetailPresenter: HeroDetailPresenter?
    var presenter: HeroDetailPresenterProtocol?
    var heroId: String?
    var heroName: String?
    var heroImageUrl: String?
    var comics: [Comic] = []
    
    // MARK: - Initializers
    
    init(_ coder: NSCoder? = nil) {
        heroDetailPresenter = HeroDetailPresenter(loadHeroDetailUseCase: LoadHeroDetailUseCase(doInBackground: true, operation: GetHeroDetailOperation(client: ApiClient())), loadHeroDetailComicsUseCase: LoadHeroDetailComicsUseCase(doInBackground: true, operation: GetHeroDetailComicsOperation(client: ApiClient())), networkProvider: NetworkProvider())
        
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
        
        // Set the delegate and data source
        customView.comicCollectionView.dataSource = self
        customView.comicCollectionView.delegate = self
        
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
    
    /// Reloads the collection list
    func reloadList() {
        customView.comicCollectionView.reloadData()
    }
}

// MARK: - HeroDetailViewProtocol protocol conformance

extension HeroDetailViewController: HeroDetailViewProtocol {
    
    /// Show the hero information
    ///
    /// - Parameter showHero: The hero object
    func showHero(hero: Hero) {
        if hero.description != "" {
            customView.descriptionLabel.text = hero.description
            customView.descriptionLabel.isHidden = false
        }
    }
    
    /// Show the hero comics information
    ///
    /// - Parameter comicList: The hero comics
    func showComics(comicList: [Comic]) {
        comics = comicList
        reloadList()
        presenter?.displayComicsContainer(numberOfComics: comicList.count)
    }
    
    /// Display the comics header
    func showComicsHeader() {
        customView.comicHeaderLabel.isHidden = false
    }
    
    /// Hide the comics header
    func hideComicsHeader() {
        customView.comicHeaderLabel.isHidden = true
    }
    
    /// Display the comics header
    func showComicsCollection() {
        customView.comicCollectionView.isHidden = false
    }
    
    /// Hide the comics header
    func hideComicsCollection() {
        customView.comicCollectionView.isHidden = true
    }
}

// MARK: - UICollectionViewDataSource and UICollectionViewDelegate protocol conformance

extension HeroDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = customView.comicCollectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellIdentifier, for: indexPath) as! HeroDetailComicViewCell
        
        cell.displayContent(image: comics[indexPath.row].image!)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout protocol conformance

extension HeroDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/2.5
        let yourHeight = collectionView.bounds.height
        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
