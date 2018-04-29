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
            hero.id = item.id
            hero.name = item.name
            hero.description = item.description
            hero.image = item.image
        }
        
        return hero
    }
}
