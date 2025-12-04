import Foundation

enum AddContactValidationError: Error, LocalizedError {
    case emptyName
    case emptyPhone
    case emptyEmail
    case invalidPhone
    case invalidEmail

    var errorDescription: String? {
        switch self {
        case .emptyName:
            return "Name is required."
        case .emptyPhone:
            return "Phone number is required."
        case .emptyEmail:
            return "Email address is required."
        case .invalidPhone:
            return "Invalid phone number format."
        case .invalidEmail:
            return "Please enter a valid email address."
        }
    }
}
