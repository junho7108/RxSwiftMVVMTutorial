import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxRelay

class RootViewController: UIViewController {
    
    //MARK: - Properties
    
    let disposeBag = DisposeBag()
    let viewModel: RootViewModel
    
    private let articleViewModel = BehaviorRelay<[ArticleViewModel]>(value: [])
    var artivleViewModelObservable: Observable<[ArticleViewModel]> {
        return articleViewModel.asObservable()
    }
    
    //MARK: - UI Properties
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let fl = UICollectionViewFlowLayout()
        fl.itemSize = CGSize(width: view.frame.width,
                             height: 120)
        return fl
    }()
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout
    )
    
    //MARK: - Lifecycle
    
    init(viewModel: RootViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureCollectionView()
        fetchArticles()
        subscribe()
    }
    
    //MARK: - Configures
    
    func configureUI() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureCollectionView() {
        
        collectionView.register(ArticleCell.self, forCellWithReuseIdentifier: "cell")
        
        artivleViewModelObservable
            .bind(to: self.collectionView.rx.items(cellIdentifier: "cell", cellType: ArticleCell.self)) {
                [unowned self] index, article, cell in
                cell.viewModel.onNext(self.articleViewModel.value[index])
            }
            .disposed(by: disposeBag)
    }
    
    //MARK: - Helpers
    
    func fetchArticles() {
        viewModel.fetchArticle()
            .subscribe(onNext: { [weak self] articleViewModels in
                self?.articleViewModel.accept(articleViewModels)
            })
            .disposed(by: disposeBag)
    }
    
    func subscribe() {
        self.artivleViewModelObservable.bind { articles in
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        }
        .disposed(by: disposeBag)
    }
}
