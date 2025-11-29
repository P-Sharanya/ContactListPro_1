import Foundation

struct ContactDetailEntity {
    let contact: Contact
}

enum ContactAlert: Identifiable {
    case success(String)
    case error(String)
    case confirmDelete(Contact)
    
    var id: String {
        switch self {
        case .success(let msg): return "success-\(msg)"
        case .error(let msg): return "error-\(msg)"
        case .confirmDelete(let c): return "confirm-\(c.id.uuidString)"
        }
    }
}
