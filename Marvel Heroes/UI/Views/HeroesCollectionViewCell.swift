import UIKit
import Kingfisher

/// Heroes collection view cell
class HeroesCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroInfoView: UIView! {
        didSet {
            heroInfoView.backgroundColor = .black
            heroInfoView.alpha = 0.8
        }
    }
    @IBOutlet weak var heroName: UILabel! {
        didSet {
            heroName.textColor = .white
            heroName.font = UIFont.boldSystemFont(ofSize: 15.0)
        }
    }
    
    // MARK: - Initializer
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Methods
    
    /// Display the content in the cell
    ///
    /// - Parameters:
    ///   - image: The hero picture url
    ///   - name: The hero name
    func displayContent(image: String, name: String) {
        // Image cache
        heroImage.kf.setImage(with: URL(string: image)!)
        
        // Remove all parenthesis to avoid having a long hero name
        let array = name.components(separatedBy: " (")
        heroName.text = array[0]
    }
}
