import UIKit

/// Heroes collection view
class HeroesCollectionView: UIView {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var navigationBar: UINavigationBar! {
        didSet {
            navigationBar.isTranslucent = false
            navigationBar.backgroundColor = .black
            navigationBar.tintColor = .white
        }
    }
    @IBOutlet weak var navigationItem: UINavigationItem! {
        didSet {
            navigationItem.title = "Marvel Heroes"
        }
    }
    @IBOutlet weak var heroCollectionView: UICollectionView! {
        didSet {
            heroCollectionView.isHidden = true
        }
    }
    @IBOutlet weak var loadingView: UIView! {
        didSet {
            loadingView.isHidden = true
        }
    }
    @IBOutlet weak var loadingLabel: UILabel! {
        didSet {
            loadingLabel.text = "Loading heroes..."
            loadingLabel.font = loadingLabel.font.withSize(12.0)
        }
    }
    @IBOutlet weak var errorView: UIView! {
        didSet {
            errorView.isHidden = true
        }
    }
    @IBOutlet weak var errorLabel: UILabel! {
        didSet {
            errorLabel.text = "Something went wrong"
            errorLabel.font = errorLabel.font.withSize(12.0)
        }
    }
    @IBOutlet weak var errorButton: UIButton! {
        didSet {
            errorButton.setTitle("Try again", for: .normal)
            errorButton.backgroundColor = .black
            errorButton.tintColor = .white
        }
    }
    @IBOutlet weak var errorLoadingMoreHeroesView: UIView! {
        didSet {
            errorLoadingMoreHeroesView.isHidden = true
            errorLoadingMoreHeroesView.backgroundColor = .black
            errorLoadingMoreHeroesView.alpha = 0.9
        }
    }
    @IBOutlet weak var errorLoadingMoreHeroesLabel: UILabel! {
        didSet {
            errorLoadingMoreHeroesLabel.text = "Unable to load more heroes"
            errorLoadingMoreHeroesLabel.font = errorLoadingMoreHeroesLabel.font.withSize(12.0)
            errorLoadingMoreHeroesLabel.textColor = .white
        }
    }
    
    // MARK: - Constants
    
    let viewName = "HeroesCollectionView"
    let collectionViewCell = "HeroesCollectionViewCell"
    let collectionViewCellIdentifier = "HeroesCollectionCell"
    
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
        heroCollectionView.register(nibName, forCellWithReuseIdentifier: collectionViewCellIdentifier)
    }
}
