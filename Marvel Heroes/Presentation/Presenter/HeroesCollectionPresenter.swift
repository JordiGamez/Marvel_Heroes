//
//  HeroesCollectionPresenter.swift
//  Marvel Heroes
//
//  Created by Jordi Gamez on 28/4/18.
//  Copyright © 2018 Jordi Gamez. All rights reserved.
//

import Foundation

class HeroesCollectionPresenter {
    
    // MARK: - Constants
    
    let tag = String(describing: HeroesCollectionPresenter.self)
    let loadHeroesUseCase: LoadHeroesUseCase?
    
    // MARK: - Variables
    
    var view: HeroesCollectionViewProtocol?
    
    // MARK: - Initializers
    
    init(loadHeroesUseCase: LoadHeroesUseCase) {
        self.loadHeroesUseCase = loadHeroesUseCase
    }
}

// MARK: - HeroesCollectionPresenterProtocol protocol conformance

extension HeroesCollectionPresenter: HeroesCollectionPresenterProtocol {
    
    /// Bind the presenter and the view
    ///
    /// - Parameter view: A HeroesCollectionViewProtocol conformance object
    func bind(view: HeroesCollectionViewProtocol) {
        self.view = view
    }
    
    /// Load heroes
    func loadHeroes() {
        
    }
}
