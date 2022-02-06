import UIKit

class RootViewController: UIViewController {
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Configures
    func configureUI() {
        view.backgroundColor = .red
    }
}
