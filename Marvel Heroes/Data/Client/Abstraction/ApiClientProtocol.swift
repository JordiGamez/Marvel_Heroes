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
    /// - Returns: A HeroEntity object
    /// - Throws: Exception
    func getHeroes() throws -> HeroEntity?
}
