//
//  HeroMapper.swift
//  Marvel Heroes
//
//  Created by Jordi Gamez on 28/4/18.
//  Copyright © 2018 Jordi Gamez. All rights reserved.
//

import Foundation

class HeroMapper {
    
    func transform(_ entity: HeroEntity) -> [Hero] {
        
        var heroList: [Hero] = []
        
        for item in entity.heroes {
            let hero = Hero()
            hero.name = item.name
            hero.image = item.image
            
            heroList.append(hero)
        }
        
        return heroList
    }
}
