//
//  LoadHeroesUseCase.swift
//  Marvel Heroes
//
//  Created by Jordi Gamez on 28/4/18.
//  Copyright © 2018 Jordi Gamez. All rights reserved.
//

import Foundation

class LoadHeroesUseCase: BaseUseCase<LoadHeroesResult, LoadHeroesParams> {
    
    // MARK: - Variables
    
    private var operation: GetHeroesOperationProtocol
    
    // MARK: - Initializer
    
    init(doInBackground: Bool = false, operation: GetHeroesOperationProtocol) {
        self.operation = operation
        super.init(doInBackground: doInBackground)
    }
    
    // MARK: - Methods
    
    override func execute(params: LoadHeroesParams) {
        do {
            let result = try operation.perform()
            let loadHeroesResult = LoadHeroesResult()
            loadHeroesResult.hero = result
            onResult(result: loadHeroesResult)
        } catch let exception {
            // TODO: Handle the exception
        }
    }
}
