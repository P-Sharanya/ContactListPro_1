import UIKit
import SwiftUI

final class AddContactRouter: AddContactRouterProtocol {
    weak var viewController: UIViewController?
    weak var navigationController: UINavigationController?
    
    func dismiss() {
        navigationController?.popViewController(animated: true)
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            if let top = self.navigationController?.topViewController as? UIHostingController<ContactListView> {
                top.rootView.presenter.refreshAfterAdd()
            }
        }
    }
}
