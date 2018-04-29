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
    
    // Decodes the JSON
    init(from decoder: Decoder) throws {
        var comicsList: [ComicDetailInfo] = []
        
        let containerRoot = try decoder.container(keyedBy: RootKeys.self)
        let containerData = try containerRoot.nestedContainer(keyedBy: DataKeys.self, forKey: .data)
        
        var resultsUnkeyedContainer = try containerData.nestedUnkeyedContainer(forKey: .results)
        
        while !resultsUnkeyedContainer.isAtEnd {
            let resultsContainer = try resultsUnkeyedContainer.nestedContainer(keyedBy: ResultsKeys.self)
            
            let thumbnailContainer = try resultsContainer.nestedContainer(keyedBy: ThumbnailKeys.self, forKey: .thumbnail)
            let thumbnailPath = try thumbnailContainer.decode(String.self, forKey: .path)
            let thumbnailExtension = try thumbnailContainer.decode(String.self, forKey: .thumbnailExtension)
            
            comicsList.append(ComicDetailInfo(
                id: String(try resultsContainer.decode(Int.self, forKey: .id)),
                title: try resultsContainer.decode(String.self, forKey: .title),
                image: thumbnailPath + "." + thumbnailExtension
                )
            )
        }
        
        comics = comicsList
    }
}
