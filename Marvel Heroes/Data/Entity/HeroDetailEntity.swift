//
//  HeroDetailEntity.swift
//  Marvel Heroes
//
//  Created by Jordi Gamez on 29/4/18.
//  Copyright © 2018 Jordi Gamez. All rights reserved.
//

import Foundation

/// HeroEntity for the data layer
struct HeroDetailEntity {
    
    // MARK: - Variables
    
    var heroes: [HeroDetailInfo]
    
    // MARK: - Enums
    
    enum RootKeys: String, CodingKey {
        case data
    }
    
    enum DataKeys: String, CodingKey {
        case results
    }
    
    enum ResultsKeys: String, CodingKey {
        case id, name, description, thumbnail
    }
    
    enum ThumbnailKeys: String, CodingKey {
        case path, thumbnailExtension = "extension"
    }
    
    // MARK: - Structs
    
    struct HeroDetailInfo: Decodable {
        var id: String
        var name: String
        var description: String
        var image: String
    }
}

// MARK: - Decodable protocol conformance

extension HeroDetailEntity: Decodable {
    
    init(from decoder: Decoder) throws {
        var heroesAux: [HeroDetailInfo] = []
        
        let containerRoot = try decoder.container(keyedBy: RootKeys.self)
        let containerData = try containerRoot.nestedContainer(keyedBy: DataKeys.self, forKey: .data)
        do {
            var resultsUnkeyedContainer = try containerData.nestedUnkeyedContainer(forKey: .results)
            while !resultsUnkeyedContainer.isAtEnd {
                let resultsContainer = try resultsUnkeyedContainer.nestedContainer(keyedBy: ResultsKeys.self)
                
                let thumbnailContainer = try resultsContainer.nestedContainer(keyedBy: ThumbnailKeys.self, forKey: .thumbnail)
                let thumbnailPath = try thumbnailContainer.decode(String.self, forKey: .path)
                let thumbnailExtension = try thumbnailContainer.decode(String.self, forKey: .thumbnailExtension)
                
                heroesAux.append(HeroDetailInfo(
                    id: String(try resultsContainer.decode(Int.self, forKey: .id)),
                    name: try resultsContainer.decode(String.self, forKey: .name),
                    description: try resultsContainer.decode(String.self, forKey: .description),
                    image: thumbnailPath + "." + thumbnailExtension
                    )
                )
            }
        } catch let error {
            print(error)
        }
        
        heroes = heroesAux
    }
}
