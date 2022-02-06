import UIKit

class Coordinator {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let rootViewController = RootViewController(viewModel: RootViewModel(articleService: ArticleService()))
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        window.rootViewController = navigationVC
        window.makeKeyAndVisible()
    }
}
