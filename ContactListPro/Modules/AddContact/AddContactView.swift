import SwiftUI

struct AddContactView: View {
    @State private var name = ""
    @State private var phone = ""
    @State private var email = ""
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        Form {
            Section(header: Text("Name")) {
                TextField("Enter name", text: $name)
            }
            Section(header: Text("Phone")) {
                TextField("Enter phone", text: $phone)
                    .keyboardType(.phonePad)
            }
            Section(header: Text("Email")) {
                TextField("Enter email", text: $email)
                    .keyboardType(.emailAddress)
            }
            
            Button(action: saveContact) {
                Label("Save Contact", systemImage: "tray.and.arrow.down")
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .navigationTitle("Add Contact")
    }
    
    private func saveContact() {
        
        guard !name.isEmpty, !phone.isEmpty, !email.isEmpty else { return }
        
        
        let storage = ContactStorage()
        var contacts = storage.fetch()
        let newContact = Contact(name: name, phone: phone, email: email)
        contacts.append(newContact)
        storage.save(contacts)
        
        
        name = ""
        phone = ""
        email = ""
        
        
        router.goBackToList()
    }
}

