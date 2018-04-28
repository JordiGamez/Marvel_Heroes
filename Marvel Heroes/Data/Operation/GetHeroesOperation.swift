//
//  GetHeroesOperation.swift
//  Marvel Heroes
//
//  Created by Jordi Gamez on 28/4/18.
//  Copyright © 2018 Jordi Gamez. All rights reserved.
//

import Foundation

class GetHeroesOperation {
    
    // MARK: - Variables
    
    var dataSource: ApiClientProtocol
    
    // MARK: - Initializers
    
    init(dataSource: ApiClientProtocol) {
        self.dataSource = dataSource
    }
}

// MARK: - GetHeroesOperationProtocol protocol conformance

extension GetHeroesOperation: GetHeroesOperationProtocol {

    func perform() throws -> [Hero] {
        do {
            let result = try dataSource.getHeroes()
            let heroMapper = HeroMapper()
            return heroMapper.transform(result!)
        } catch let exception {
            throw exception
        }
    }
}
