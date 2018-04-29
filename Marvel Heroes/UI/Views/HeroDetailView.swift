import UIKit

/// Hero detail view
class HeroDetailView: UIView {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var navigationBar: UINavigationBar! {
        didSet {
            navigationBar.isTranslucent = false
            navigationBar.backgroundColor = .black
            navigationBar.tintColor = .white
        }
    }
    @IBOutlet weak var navigationTitle: UINavigationItem! {
        didSet {
            navigationTitle.title = "Hero details"
        }
    }
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        }
    }
    @IBOutlet weak var imageUIImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.font = descriptionLabel.font.withSize(16.0)
        }
    }
    
    // MARK: - Constants
    
    let viewName = "HeroDetailView"
    
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
}
