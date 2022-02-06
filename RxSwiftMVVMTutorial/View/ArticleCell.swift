import UIKit
import RxSwift
import SDWebImage

class ArticleCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    let disposeBag = DisposeBag()
    
    var viewModel = PublishSubject<ArticleViewModel>()
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 8
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .secondarySystemBackground
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "A"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "b"
        label.numberOfLines = 3
        return label
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        subscribe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func subscribe() {
        self.viewModel
            .bind { [weak self] articleViewModel in
                if let urlString = articleViewModel.imageUrl {
                    self?.imageView.sd_setImage(with: URL(string: urlString), completed: nil)
                }
                
                self?.titleLabel.text = articleViewModel.title
                self?.descriptionLabel.text = articleViewModel.description
                
            }.disposed(by: disposeBag)
    }
    
    //MARK: - Configures
    
    func configureUI() {
        backgroundColor = .systemBackground
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.top)
            make.leading.equalTo(imageView.snp.trailing).offset(20)
            make.trailing.equalToSuperview().inset(40)
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(titleLabel)
        }
    }
}
