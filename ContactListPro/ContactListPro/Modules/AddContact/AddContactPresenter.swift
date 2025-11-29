
import Foundation

// MARK: - String Regex Helper
extension String {
    func matches(_ pattern: String) -> Bool {
        return range(of: pattern, options: .regularExpression) != nil
    }
}
// MARK: - Presenter
final class AddContactPresenter: ObservableObject, AddContactPresenterProtocol {
    
    private let interactor: AddContactInteractorProtocol
    private let router: AddContactRouterProtocol
    var view: AddContactViewProtocol?
    
    init(interactor: AddContactInteractorProtocol,
         router: AddContactRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: - Actions
    func didTapSave(name: String, phone: String, email: String) {
        do {
            try validate(name: name, phone: phone, email: email)
            try interactor.saveContact(name: name, phone: phone, email: email)
            
            router.dismiss()
        } catch let error as AddContactValidationError {
            view?.showValidationError(error.localizedDescription)
        } catch let error as StorageError {
            view?.showValidationError(error.localizedDescription)
        } catch {
            view?.showValidationError("An unexpected error occurred.")
        }
    }
    
    func didTapCancel() {
        router.dismiss()
    }
    
    // MARK: - Validation
    private func validate(name: String, phone: String, email: String) throws {
        
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedPhone = phone.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedName.isEmpty { throw AddContactValidationError.emptyName }
        if trimmedPhone.isEmpty { throw AddContactValidationError.emptyPhone }
   
        if !trimmedPhone.matches("^[0-9]{10}$") {
            throw AddContactValidationError.invalidPhone
        }
        if trimmedEmail.isEmpty { throw AddContactValidationError.emptyEmail }
      
        if !trimmedEmail.matches("^[0-9a-z._%+-]+@[a-z0-9.-]+\\.[a-z]{2,}$") {
            throw AddContactValidationError.invalidEmail
        }
    }
}

