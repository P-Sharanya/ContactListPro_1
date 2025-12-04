import SwiftUI

struct ContactDetailView: View, ContactDetailViewProtocol {
    
    @StateObject var presenter: ContactDetailPresenter
    @State private var isEditing = false
    
    @State private var name = ""
    @State private var phone = ""
    @State private var email = ""
    
    init(presenter: ContactDetailPresenter) {
        _presenter = StateObject(wrappedValue: presenter)
    }
    
    var body: some View {
        VStack {
            if isEditing {
                Form {
                    labeledField("Name", text: $name)
                    labeledField("Phone", text: $phone)
                    labeledField("Email", text: $email)
                    Section {
                        Button {
                            presenter.didTapSaveEdit(name: name, phone: phone, email: email)
                        } label: {
                            Text("Save Changes").frame(maxWidth: .infinity)
                        }
                    }
                }
            } else {
                VStack(alignment: .leading, spacing: 20) {
                    infoRow(title: "Name", value: presenter.contact.name)
                    infoRow(title: "Phone", value: presenter.contact.phone)
                    infoRow(title: "Email", value: presenter.contact.email)
                }
                .padding(.horizontal)
                Spacer()
            }
            
            if !isEditing {
                Button(role: .destructive) {
                    presenter.requestDelete()
                } label: {
                    Text("Delete Contact")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red.opacity(0.9))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                }
            }
        }
        .navigationTitle(isEditing ? "Edit Contact" : "Contact Details")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if isEditing {
                    Button("Cancel") { isEditing = false }
                } else {
                    Button("Edit") {
                        name = presenter.contact.name
                        phone = presenter.contact.phone
                        email = presenter.contact.email
                        isEditing = true
                    }
                }
            }
        }
        .alert(item: $presenter.activeAlert) { alert in
            switch alert {
            case .confirmDelete(let contact):
                return Alert(
                    title: Text("Delete Contact"),
                    message: Text("Are you sure you want to delete \(contact.name)?"),
                    primaryButton: .destructive(Text("Delete")) {
                        presenter.deleteConfirmed()
                    },
                    secondaryButton: .cancel()
                )
            case .success(let msg):
                return Alert(
                    title: Text("Success"),
                    message: Text(msg),
                    dismissButton: .default(Text("OK")) {
                        if isEditing {
                           
                            isEditing = false
                        } else {
                            
                            presenter.afterDeleteSuccessNavigateBack()
                        }
                    }
                )
            case .error(let msg):
                return Alert(
                    title: Text("Error"),
                    message: Text(msg),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    // MARK: - Helper UI funcs
    private func labeledField(_ label: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label).font(.subheadline).foregroundColor(.gray)
            TextField(label, text: text)
                .padding(8)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)
        }
        .padding(.vertical, 4)
    }
    
    private func infoRow(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title).font(.caption).foregroundColor(.gray)
            Text(value).font(.body).foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
