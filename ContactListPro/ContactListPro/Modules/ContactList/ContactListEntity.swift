import Foundation
struct Contact: Identifiable, Equatable, Codable {
    let id: UUID
    var name: String
    var phone: String
    var email: String
    var isFromAPI: Bool = false
    
    init(id: UUID = UUID(),
         name: String,
         phone: String,
         email: String,
         isFromAPI: Bool = false) {
        self.id = id
        self.name = name
        self.phone = phone
        self.email = email
        self.isFromAPI = isFromAPI
    }
}
struct APIContact: Decodable {
    let name: String
    let phone: String
    let email: String
}
enum LoadingStates {
    case idle
    case loading([Contact])
    case loaded([Contact])       
    case error(String, Bool)
}
enum AppAlert: Identifiable {
    var id: String {
        switch self {
        case .error(let message):
            return "error-\(message)"
        case .success(let message):
            return "success-\(message)"
        case .confirmDelete(let contact):
            return "confirm-\(contact.id)"
        }
    }
    case error(String)
    case success(String)
    case confirmDelete(Contact)
}
