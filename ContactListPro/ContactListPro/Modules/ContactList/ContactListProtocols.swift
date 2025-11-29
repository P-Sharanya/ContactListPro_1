import UIKit
import SwiftUI

// MARK: - View
protocol ContactListViewProtocol {
    func showContacts(_ contacts: [Contact])
    func showEmptyState()
}

// MARK: - Presenter
protocol ContactListPresenterProtocol: AnyObject {
    func viewDidLoad()
    func loadLocalContacts()
    func didSelectContact(_ contact: Contact)
    func refreshAfterAdd()
}

// MARK: - Interactor
protocol ContactListInteractorProtocol: AnyObject {
    func fetchLocalContacts() async -> [Contact]
    func fetchAPIContacts() async throws -> [Contact]
}

// MARK: - Router
protocol ContactListRouterProtocol: AnyObject {
    var viewController: UIViewController? { get set }
    var navigationController: UINavigationController? { get set }
    func navigationToAddContacts()
    func navigationToContactDetail(presenter: ContactDetailPresenter)
}

// MARK: - Builder
protocol ContactListBuilderProtocol {
    func build(navigationController: UINavigationController) -> UIViewController
}

