import UIKit
import Kingfisher

/// Hero detail comic view cell
class HeroDetailComicViewCell: UICollectionViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var comicImage: UIImageView!
    
    // MARK: - Initializer
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Methods
    
    /// Display the content in the cell
    ///
    /// - Parameters:
    ///   - image: The comic picture url
    func displayContent(image: String) {
        // Image cache
        comicImage.kf.setImage(with: URL(string: image)!)
    }
}
