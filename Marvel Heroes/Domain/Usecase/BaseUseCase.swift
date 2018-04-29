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
    
    /// Executes the use case
    ///
    /// - Parameters:
    ///   - callback: Send a callback element to receive result events
    ///   - params: The Params class of the use case
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
    
    /// Called when the result is correct
    ///
    /// - Parameter result: The result object
    func onResult(result: T) {
        DispatchQueue.main.async {
            self.callback?.onResult(result: result)
        }
    }
    
    /// Called when there is a connectivity exception
    ///
    /// - Parameter exception: The connectivity exception
    func onConnectivityError(exception: ConnectivityException) {
        DispatchQueue.main.async {
            self.callback?.onConnectivityError(exception: exception)
        }
    }
    
    /// Called when there is an exception
    ///
    /// - Parameter exception: The exception
    func onGenericError(exception: Exception) {
        DispatchQueue.main.async {
            self.callback?.onGenericError(exception: exception)
        }
    }
}
