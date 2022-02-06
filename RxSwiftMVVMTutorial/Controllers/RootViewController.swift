import UIKit
import RxSwift
import RxCocoa
import RxRelay

class RootViewController: UIViewController {
    
    //MARK:  Properties
    
    let viewModel: RootViewModel
    let disposeBag = DisposeBag()
    
    private let articleViewModel = BehaviorRelay<[ArticleViewModel]>(value: [])
    var artivleViewModelObservable: Observable<[ArticleViewModel]> {
        return articleViewModel.asObservable()
    }
    
    //MARK:  Lifecycle
    
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
        fetchArticles()
        subscribe()
    }
    
    //MARK: Configures
    
    func configureUI() {
        view.backgroundColor = .red
    }
    
    //MARK: Helpers
    
    func fetchArticles() {
        viewModel.fetchArticle()
            .subscribe(onNext: { [weak self] articleViewModels in
                self?.articleViewModel.accept(articleViewModels)
            })
            .disposed(by: disposeBag)
    }
    
    func subscribe() {
        self.artivleViewModelObservable.bind { articles in
            // collectionView Reload
            print(articles)
        }
        .disposed(by: disposeBag)
    }
}
