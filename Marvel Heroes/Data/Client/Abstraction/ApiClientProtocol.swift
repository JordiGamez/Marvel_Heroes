//
//  ApiClientProtocol.swift
//  Marvel Heroes
//
//  Created by Jordi Gamez on 28/4/18.
//  Copyright © 2018 Jordi Gamez. All rights reserved.
//

import Foundation

protocol ApiClientProtocol {
    
    /// Gets the heroes from the Api
    ///
    /// - Parameter offset: Skip the specified number of resources in the result set
    /// - Returns: A HeroEntity object
    /// - Throws: Exception
    func getHeroes(offset: Int) throws -> HeroEntity?
    
    /// Gets all the available information of a hero
    ///
    /// - Parameter heroId: The hero id
    /// - Returns: A HeroDetailEntity object
    /// - Throws: Exception
    func getHeroDetail(heroId: String) throws -> HeroDetailEntity?
}
