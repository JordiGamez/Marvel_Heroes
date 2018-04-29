//
//  HeroDetailMapper.swift
//  Marvel Heroes
//
//  Created by Jordi Gamez on 29/4/18.
//  Copyright © 2018 Jordi Gamez. All rights reserved.
//

import Foundation

class HeroDetailMapper {
    
    func transform(_ entity: HeroDetailEntity) -> Hero {
        
        let hero = Hero()
        
        for item in entity.heroes {
            
            var comicList: [ComicDetail] = []
            
            hero.id = item.id
            hero.name = item.name
            hero.description = item.description
            hero.image = item.image
            
            for comicEntity in item.comic {
                let comic = ComicDetail()
                comic.name = comicEntity.name
                comic.resourceURI = comicEntity.resourceURI
                
                comicList.append(comic)
            }
            
            hero.comic = comicList
        }
        
        return hero
    }
}
