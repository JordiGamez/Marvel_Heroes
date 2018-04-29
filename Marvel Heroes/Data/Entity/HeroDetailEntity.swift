import Foundation

/// HeroDetailEntity for the data layer
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
        case id, name, description, thumbnail, comics
    }
    
    enum ThumbnailKeys: String, CodingKey {
        case path, thumbnailExtension = "extension"
    }
    
    enum ComicKeys: String, CodingKey {
        case items
    }
    
    enum ItemKeys: String, CodingKey {
        case resourceURI, comicName = "name"
    }
    
    // MARK: - Structs
    
    struct HeroDetailInfo: Decodable {
        var id: String
        var name: String
        var description: String
        var image: String
        var comic: [ComicEntity]
    }
}

struct ComicEntity: Decodable {
    var resourceURI: String
    var name: String
}

// MARK: - Decodable protocol conformance

extension HeroDetailEntity: Decodable {
    
    // Decodes the JSON
    init(from decoder: Decoder) throws {
        var heroesList: [HeroDetailInfo] = []
        
        let containerRoot = try decoder.container(keyedBy: RootKeys.self)
        let containerData = try containerRoot.nestedContainer(keyedBy: DataKeys.self, forKey: .data)

        var resultsUnkeyedContainer = try containerData.nestedUnkeyedContainer(forKey: .results)
        while !resultsUnkeyedContainer.isAtEnd {
            let resultsContainer = try resultsUnkeyedContainer.nestedContainer(keyedBy: ResultsKeys.self)
            
            let thumbnailContainer = try resultsContainer.nestedContainer(keyedBy: ThumbnailKeys.self, forKey: .thumbnail)
            let thumbnailPath = try thumbnailContainer.decode(String.self, forKey: .path)
            let thumbnailExtension = try thumbnailContainer.decode(String.self, forKey: .thumbnailExtension)
            
            let comicsContainer = try resultsContainer.nestedContainer(keyedBy: ComicKeys.self, forKey: .comics)
            
            var resultsComicsContainer = try comicsContainer.nestedUnkeyedContainer(forKey: .items)
            
            var comicAux: [ComicEntity] = []
            
            while !resultsComicsContainer.isAtEnd {
                let resultsComics = try resultsComicsContainer.nestedContainer(keyedBy: ItemKeys.self)
                let comicResourceURI = try resultsComics.decode(String.self, forKey: .resourceURI)
                let comicName = try resultsComics.decode(String.self, forKey: .comicName)
                
                comicAux.append(ComicEntity(resourceURI: comicResourceURI, name: comicName))
            }
            
            heroesList.append(HeroDetailInfo(
                id: String(try resultsContainer.decode(Int.self, forKey: .id)),
                name: try resultsContainer.decode(String.self, forKey: .name),
                description: try resultsContainer.decode(String.self, forKey: .description),
                image: thumbnailPath + "." + thumbnailExtension,
                comic: comicAux
                )
            )
        }
        
        heroes = heroesList
    }
}
