//
//  HeroEntity.swift
//  Marvel Heroes
//
//  Created by Jordi Gamez on 28/4/18.
//  Copyright © 2018 Jordi Gamez. All rights reserved.
//

import Foundation

struct HeroEntity: Decodable {

    let data: DataDetails

    struct DataDetails: Decodable {

        let results: [ResultsDetails]

        struct ResultsDetails: Decodable {

            let name: String
        }
    }
}
