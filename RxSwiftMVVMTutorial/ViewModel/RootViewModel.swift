import Foundation
import RxSwift

final class RootViewModel {
    let title = "junho"
    
    private let articleService: ArticleServiceProtocol
    
    init(articleService: ArticleServiceProtocol) {
        self.articleService = articleService
    }
    
    func fetchArticle() -> Observable<[ArticleViewModel]> {
        return articleService.fetchNews()
            .map { $0.map { ArticleViewModel(article: $0)}}
    }
}
