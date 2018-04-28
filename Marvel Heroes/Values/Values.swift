//
//  Values.swift
//  Marvel Heroes
//
//  Created by Jordi Gamez on 28/4/18.
//  Copyright © 2018 Jordi Gamez. All rights reserved.
//

import Foundation

enum Values {
    
    enum Server {
        
        enum Api: String {
            
            case Url = "http://gateway.marvel.com/v1/public/"
            
            case PublicKey = "394a5b939b49d78b49c8c77070616649"
            
            case PrivateKey = "faac9f26828ac472ffc438038f5cfd3b30a3a581"
        }
        
        enum Endpoints: String {
            
            case Characters = "characters"
        }
    }
}
