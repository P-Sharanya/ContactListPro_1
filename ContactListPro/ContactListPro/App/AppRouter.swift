import SwiftUI  

final class AppRouter: ObservableObject {
    static let shared = AppRouter()
    
    enum Route {
        case contactList
        case addContact
        case contactDetail
    }
    
  
    @Published var currentRoute: Route = .contactList
    @Published var selectedContact: Contact?
    
    func goBackToList() {
        currentRoute = .contactList
        selectedContact = nil
    }

}

