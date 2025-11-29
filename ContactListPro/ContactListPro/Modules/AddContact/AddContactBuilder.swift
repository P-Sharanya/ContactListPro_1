import UIKit
import SwiftUI

final class AddContactBuilder {
    func build(navigationController: UINavigationController?) -> UIViewController {
        let interactor = AddContactInteractor()
        let router = AddContactRouter()
        let presenter = AddContactPresenter(interactor: interactor, router: router)
        
        let view = AddContactView(presenter: presenter)
        presenter.view = view
        
        let hostingVC = UIHostingController(rootView: view)
        router.viewController = hostingVC
        
        router.navigationController = navigationController
        return hostingVC
    }
}
