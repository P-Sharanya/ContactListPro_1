import UIKit
import SwiftUI

final class ContactDetailBuilder: ContactDetailBuilderProtocol {
    
    func build(with contact: Contact, presenter: ContactDetailPresenter) -> UIViewController {
        
        let view = ContactDetailView(presenter: presenter)
        let controller = UIHostingController(rootView: view)
        
        if let router = presenter.router as? ContactDetailRouter {
            router.viewController = controller
            
        }
        return controller
    }
    
    
    func build(with contact: Contact) -> UIViewController {
        
        let interactor = ContactDetailInteractor()
        let router = ContactDetailRouter()
        
        let presenter = ContactDetailPresenter(contact: contact, interactor: interactor, router: router)
        return build(with: contact, presenter: presenter)
    }
}
