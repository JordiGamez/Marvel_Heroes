import Foundation

/// HeroEntity for the data layer
struct HeroEntity {
    
    // MARK: - Variables
    
    var heroes: [HeroInfo]
    
    // MARK: - Enums
    
    enum RootKeys: String, CodingKey {
        case data
    }
    
    enum DataKeys: String, CodingKey {
        case results
    }
    
    enum ResultsKeys: String, CodingKey {
        case id, name, thumbnail
    }
    
    enum ThumbnailKeys: String, CodingKey {
        case path, thumbnailExtension = "extension"
    }
    
    // MARK: - Structs
    
    struct HeroInfo: Decodable {
        var id: String
        var name: String
        var image: String
    }
}

// MARK: - Decodable protocol conformance

extension HeroEntity: Decodable {
    
    // Decodes the JSON
    init(from decoder: Decoder) throws {
        var heroesList: [HeroInfo] = []
        
        let containerRoot = try decoder.container(keyedBy: RootKeys.self)
        let containerData = try containerRoot.nestedContainer(keyedBy: DataKeys.self, forKey: .data)

        var resultsUnkeyedContainer = try containerData.nestedUnkeyedContainer(forKey: .results)
        while !resultsUnkeyedContainer.isAtEnd {
            let resultsContainer = try resultsUnkeyedContainer.nestedContainer(keyedBy: ResultsKeys.self)
            
            let thumbnailContainer = try resultsContainer.nestedContainer(keyedBy: ThumbnailKeys.self, forKey: .thumbnail)
            let thumbnailPath = try thumbnailContainer.decode(String.self, forKey: .path)
            let thumbnailExtension = try thumbnailContainer.decode(String.self, forKey: .thumbnailExtension)
            
            heroesList.append(HeroInfo(
                id: String(try resultsContainer.decode(Int.self, forKey: .id)),
                name: try resultsContainer.decode(String.self, forKey: .name),
                image: thumbnailPath + "." + thumbnailExtension)
            )
        }

        heroes = heroesList
    }
}
