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
    @IBOutlet weak var heroCollectionView: UICollectionView!
    
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
