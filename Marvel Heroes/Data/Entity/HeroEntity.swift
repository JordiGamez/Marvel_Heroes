//
//  HeroEntity.swift
//  Marvel Heroes
//
//  Created by Jordi Gamez on 28/4/18.
//  Copyright © 2018 Jordi Gamez. All rights reserved.
//

import Foundation

struct HeroEntity {
    
    enum RootKeys: String, CodingKey {
        case data = "data"
    }
    
    enum DataKeys: String, CodingKey {
        case results = "results"
    }
    
    enum ResultsKeys: String, CodingKey {
        case name = "name", thumbnail
    }
    
    enum ThumbnailKeys: String, CodingKey {
        case thumbnailPath = "path", thumbnailExtension = "extension"
    }

    var heroes: [HeroAux]
}

struct HeroAux: Decodable {
    var name: String
    var image: Image = Image(thumbnailPath: "", thumbnailExtension: "")
}

struct Image: Codable {
    var thumbnailPath: String
    var thumbnailExtension: String
}

extension HeroEntity: Decodable {
    
    init(from decoder: Decoder) throws {
        var heroesAux: [HeroAux] = []
        
        let containerRoot = try decoder.container(keyedBy: RootKeys.self)
        let containerData = try containerRoot.nestedContainer(keyedBy: DataKeys.self, forKey: .data)
        do {
            var resultsUnkeyedContainer = try containerData.nestedUnkeyedContainer(forKey: .results)
            while !resultsUnkeyedContainer.isAtEnd {
                let reviewCountContainer = try resultsUnkeyedContainer.nestedContainer(keyedBy: ResultsKeys.self)
                heroesAux.append(HeroAux(name: try reviewCountContainer.decode(String.self, forKey: .name), image: Image(thumbnailPath: "", thumbnailExtension: "")))
            }
        } catch let error {
            print(error)
        }

        heroes = heroesAux
    }
}
