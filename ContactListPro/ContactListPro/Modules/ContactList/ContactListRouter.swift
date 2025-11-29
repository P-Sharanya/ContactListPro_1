import UIKit
import SwiftUI

final class ContactListRouter: ContactListRouterProtocol {
    weak var viewController: UIViewController?
    weak var navigationController: UINavigationController?
    
    init(viewController: UIViewController? = nil,
         navigationController: UINavigationController? = nil) {
        self.viewController = viewController
        self.navigationController = navigationController
    }

    func navigationToAddContacts() {
        let addVC = AddContactBuilder().build(navigationController: navigationController)
        navigationController?.pushViewController(addVC, animated: true)
    }
    
    func navigationToContactDetail(presenter: ContactDetailPresenter) {
        if let detailRouter = presenter.router as? ContactDetailRouter {
            detailRouter.navigationController = navigationController
        }
        let vc = ContactDetailBuilder().build(with: presenter.contact, presenter: presenter)
        navigationController?.pushViewController(vc, animated: true)
    }
}

