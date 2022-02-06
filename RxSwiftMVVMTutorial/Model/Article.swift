import Foundation

struct ArticleResult: Codable {
    var status: String
    var totalResults: Int
    let articles: [Article]
}

struct Article: Codable {
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
}
