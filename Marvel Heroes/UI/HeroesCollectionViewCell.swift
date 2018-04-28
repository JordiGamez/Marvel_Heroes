import UIKit

/// Heroes collection view cell
class HeroesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroName: UILabel!
    
    // MARK: - Methods
    
    /// Display the content in the cell
    ///
    /// - Parameters:
    ///   - image: The hero picture
    ///   - name: The hero name
    func displayContent(image: UIImage, name: String) {
        heroImage.image = image
        heroName.text = name
    }
}

