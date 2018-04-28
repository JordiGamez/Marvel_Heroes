//
//  UseCase.swift
//  Marvel Heroes
//
//  Created by Jordi Gamez on 28/4/18.
//  Copyright © 2018 Jordi Gamez. All rights reserved.
//

import Foundation

class UseCase<Result, Parameters> {
    
    /// Executes the use case
    ///
    /// - Parameters:
    ///   - callback: Send a callback element to receive result events
    ///   - params: The Param class of the use case
    func execute(callback: Callback<Result>, params: Parameters) {}
}
