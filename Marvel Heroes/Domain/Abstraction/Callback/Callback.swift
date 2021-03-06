//
//  Callback.swift
//  Marvel Heroes
//
//  Created by Jordi Gamez on 28/4/18.
//  Copyright © 2018 Jordi Gamez. All rights reserved.
//

import Foundation

class Callback<Result> {
    
    func onResult(result: Result) {}
    
    func onConnectivityError(exception: ConnectivityException) {}
    
    func onGenericError(exception: Exception) {}
}
