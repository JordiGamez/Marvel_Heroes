import Foundation

/// HeroEntity for the data layer
struct HeroEntity {
    
    // MARK: - Variables
    
    var heroes: [HeroAux]
    
    // MARK: - Enums
    
    enum RootKeys: String, CodingKey {
        case data
    }
    
    enum DataKeys: String, CodingKey {
        case results
    }
    
    enum ResultsKeys: String, CodingKey {
        case name, thumbnail
    }
    
    enum ThumbnailKeys: String, CodingKey {
        case path, thumbnailExtension = "extension"
    }
    
    // MARK: - Structs
    
    struct HeroAux: Decodable {
        var name: String
        var image: String
    }
}

// MARK: - Decodable protocol conformance

extension HeroEntity: Decodable {
    
    init(from decoder: Decoder) throws {
        var heroesAux: [HeroAux] = []
        
        let containerRoot = try decoder.container(keyedBy: RootKeys.self)
        let containerData = try containerRoot.nestedContainer(keyedBy: DataKeys.self, forKey: .data)
        do {
            var resultsUnkeyedContainer = try containerData.nestedUnkeyedContainer(forKey: .results)
            while !resultsUnkeyedContainer.isAtEnd {
                let resultsContainer = try resultsUnkeyedContainer.nestedContainer(keyedBy: ResultsKeys.self)
                
                let thumbnailContainer = try resultsContainer.nestedContainer(keyedBy: ThumbnailKeys.self, forKey: .thumbnail)
                let thumbnailPath = try thumbnailContainer.decode(String.self, forKey: .path)
                let thumbnailExtension = try thumbnailContainer.decode(String.self, forKey: .thumbnailExtension)
                
                heroesAux.append(HeroAux(
                    name: try resultsContainer.decode(String.self, forKey: .name),
                    image: thumbnailPath + "." + thumbnailExtension)
                )
            }
        } catch let error {
            print(error)
        }

        heroes = heroesAux
    }
}
