import UIKit

final class ContactDetailRouter: ContactDetailRouterProtocol {
    
    weak var viewController: UIViewController?
    weak var navigationController: UINavigationController?
    
    init() {}
    
    func navigateBackToContactList() {
        navigationController?.popViewController(animated: true)
    }
}

