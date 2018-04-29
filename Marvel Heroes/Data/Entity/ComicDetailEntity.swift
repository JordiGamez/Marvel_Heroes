//
//  ComicDetailEntity.swift
//  Marvel Heroes
//
//  Created by Jordi Gamez on 29/4/18.
//  Copyright © 2018 Jordi Gamez. All rights reserved.
//

import Foundation

/// ComicDetailEntity for the data layer
struct ComicDetailEntity {
    
    // MARK: - Variables
    
    var comics: [ComicDetailInfo]
    
    // MARK: - Enums
    
    enum RootKeys: String, CodingKey {
        case data
    }
    
    enum DataKeys: String, CodingKey {
        case results
    }
    
    enum ResultsKeys: String, CodingKey {
        case id, title, thumbnail
    }
    
    enum ThumbnailKeys: String, CodingKey {
        case path, thumbnailExtension = "extension"
    }
    
    // MARK: - Structs
    
    struct ComicDetailInfo: Decodable {
        var id: String
        var title: String
        var image: String
    }
}

// MARK: - Decodable protocol conformance

extension ComicDetailEntity: Decodable {
    
    init(from decoder: Decoder) throws {
        var heroesAux: [ComicDetailInfo] = []
        
        let containerRoot = try decoder.container(keyedBy: RootKeys.self)
        let containerData = try containerRoot.nestedContainer(keyedBy: DataKeys.self, forKey: .data)
        do {
            var resultsUnkeyedContainer = try containerData.nestedUnkeyedContainer(forKey: .results)
            while !resultsUnkeyedContainer.isAtEnd {
                let resultsContainer = try resultsUnkeyedContainer.nestedContainer(keyedBy: ResultsKeys.self)
                
                let thumbnailContainer = try resultsContainer.nestedContainer(keyedBy: ThumbnailKeys.self, forKey: .thumbnail)
                let thumbnailPath = try thumbnailContainer.decode(String.self, forKey: .path)
                let thumbnailExtension = try thumbnailContainer.decode(String.self, forKey: .thumbnailExtension)
                
//                let comicsContainer = try resultsContainer.nestedContainer(keyedBy: ComicKeys.self, forKey: .comics)
//
//                var resultsComicsContainer = try comicsContainer.nestedUnkeyedContainer(forKey: .items)
//
//                var comicAux: [ComicEntity] = []
//
//                while !resultsComicsContainer.isAtEnd {
//                    let resultsComics = try resultsComicsContainer.nestedContainer(keyedBy: ItemKeys.self)
//                    let comicResourceURI = try resultsComics.decode(String.self, forKey: .resourceURI)
//                    let comicName = try resultsComics.decode(String.self, forKey: .comicName)
//
//                    comicAux.append(ComicEntity(resourceURI: comicResourceURI, name: comicName))
//                }
                
                heroesAux.append(ComicDetailInfo(
                    id: String(try resultsContainer.decode(Int.self, forKey: .id)),
                    title: try resultsContainer.decode(String.self, forKey: .title),
                    image: thumbnailPath + "." + thumbnailExtension
                    )
                )
            }
        } catch let error {
            print(error)
        }
        
        comics = heroesAux
    }
}
