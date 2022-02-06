import Alamofire
import RxSwift

class ArticleService {
    
    func fetchNews() -> Observable<[Article]> {
        return Observable.create { observer -> Disposable in
            
            self.fetchNews { result in
            
                switch result {
                case .failure(let error): observer.onError(error)
                    
                case .success(let articles):
                    observer.onNext(articles)
                    observer.onCompleted()
                }
            }
            
            return Disposables.create()
        }
    }
    
    private func fetchNews(completion: @escaping ((Result<[Article], Error>) -> Void)) {
        let urlString = "https://newsapi.org/v2/everything?q=tesla&from=2022-01-06&sortBy=publishedAt&apiKey=8da1cae9b8894d3da2755042cbbd4893"
        
        guard let url = URL(string: urlString) else {
            return completion(.failure(NSError(domain: "junho7108", code: 404, userInfo: nil)))
        }
        
        AF.request(url, method: .get,
                                 parameters: nil,
                                 encoding: JSONEncoding.default,
                                 headers: nil, interceptor: nil, requestModifier: nil)
            .responseDecodable(of: ArticleResult.self) { response in
                if let error = response.error {
                    return completion(.failure(error))
                }
                
                if let articles = response.value?.articles {
                    return completion(.success(articles))
                }
            }
    }
}
