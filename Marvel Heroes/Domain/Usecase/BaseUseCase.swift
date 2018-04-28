//
//  BaseUseCase.swift
//  Marvel Heroes
//
//  Created by Jordi Gamez on 28/4/18.
//  Copyright © 2018 Jordi Gamez. All rights reserved.
//

import Foundation

class BaseUseCase<T, Params>: UseCase<T, Params> {
    
    // MARK: - Variables
    
    private var doInBackground = false
    private var callback: Callback<T>?
    
    // MARK: - Typealias
    
    typealias Result = T
    typealias Parameters = Params
    
    // MARK: - Initializer
    
    init(doInBackground: Bool) {
        self.doInBackground = doInBackground
    }
    
    // MARK: - Methods
    
    override func execute(callback: Callback<Result>, params: Parameters) {
        self.callback = callback
        
        if doInBackground {
            DispatchQueue.global().async {
                self.execute(params: params)
            }
        } else {
            self.execute(params: params)
        }
    }
    
    func execute(params: Parameters) { fatalError() }
    
    func onResult(result: T) {
        DispatchQueue.main.async {
            self.callback?.onResult(result: result)
        }
    }
}
