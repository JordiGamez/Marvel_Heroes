//
//  ComicDetailMapper.swift
//  Marvel Heroes
//
//  Created by Jordi Gamez on 29/4/18.
//  Copyright © 2018 Jordi Gamez. All rights reserved.
//

import Foundation

class ComicDetailMapper {
    
    /// Maps the ComicDetailEntity to Comic
    ///
    /// - Parameter entity: ComicDetailEntity
    /// - Returns: Comic array
    func transform(_ entity: ComicDetailEntity) -> [Comic] {
        
        var comicList: [Comic] = []
        
        for item in entity.comics {
            let comic = Comic()
            
            comic.id = item.id
            comic.name = item.title
            comic.image = item.image
            
            comicList.append(comic)
        }
        
        return comicList
    }
}
