import UIKit

/// Hero detail view
class HeroDetailView: UIView {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
            nameLabel.textColor = .white
        }
    }
    @IBOutlet weak var imageUIImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.isHidden = true
            descriptionLabel.font = descriptionLabel.font.withSize(14.0)
            descriptionLabel.textColor = .white
        }
    }
    @IBOutlet weak var comicHeaderLabel: UILabel! {
        didSet {
            comicHeaderLabel.isHidden = true
            comicHeaderLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
            comicHeaderLabel.text = "Comics"
        }
    }
    @IBOutlet weak var comicCollectionView: UICollectionView! {
        didSet {
            comicCollectionView.isHidden = true
        }
    }
    @IBOutlet weak var loadingView: UIView! {
        didSet {
            loadingView.isHidden = true
        }
    }
    @IBOutlet weak var loadingLabel: UILabel! {
        didSet {
            loadingLabel.text = "Searching comics..."
            loadingLabel.font = loadingLabel.font.withSize(12.0)
        }
    }
    
    // MARK: - Constants
    
    let viewName = "HeroDetailView"
    let collectionViewCell = "HeroDetailComicViewCell"
    let collectionViewCellIdentifier = "ComicsCollectionCell"
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    // MARK: - Private methods
    
    /// Initialise the custom view
    private func initView() {
        Bundle.main.loadNibNamed(viewName, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    override func awakeFromNib() {
        let nibName = UINib(nibName: collectionViewCell, bundle: nil)
        comicCollectionView.register(nibName, forCellWithReuseIdentifier: collectionViewCellIdentifier)
    }
}
