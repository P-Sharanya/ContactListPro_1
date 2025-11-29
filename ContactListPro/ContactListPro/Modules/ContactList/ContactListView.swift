import SwiftUI

struct ContactListView: View {
    
    @StateObject var presenter: ContactListPresenter

    @State private var contacts: [Contact] = []
    @State private var showEmptyMessage = true
    
    init(presenter: ContactListPresenter) {
        _presenter = StateObject(wrappedValue: presenter)
    }
    
    var body: some View {
        VStack {
            switch presenter.loadingState {
            case .idle:
                VStack {
                    Spacer()
                    ProgressView("Loading...")
                        .scaleEffect(1.5)
                        .padding()
                    Spacer()
                }
            case .loading(let placeholders):
                List(placeholders) { placeholder in
                    HStack {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(placeholder.name).font(.headline).redacted(reason: .placeholder)
                            Text(placeholder.phone).font(.subheadline).foregroundColor(.secondary).redacted(reason: .placeholder)
                        }
                        Spacer()
                        Text(placeholder.email).font(.caption).foregroundColor(.secondary).redacted(reason: .placeholder)
                    }.padding(.vertical, 8)
                }.listStyle(PlainListStyle())
            case .loaded(let list):
                if list.isEmpty {
                    VStack {
                        Spacer()
                        Button(action: { presenter.didTapAddContact() }) { Image(systemName: "plus") }
                        Text("No contacts yet. Tap '+' to add new contact.")
                            .foregroundColor(.gray).padding()
                        Spacer()
                    }
                } else {
                    List(list) { contact in
                        Button(action: { presenter.didSelectContact(contact) }) {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(contact.name).font(.headline)
                                    Text(contact.email).font(.caption).foregroundColor(.secondary)
                                }
                                Spacer()
                                Text(contact.phone).foregroundColor(.secondary)
                            }.padding(.vertical, 8)
                        }
                    }.listStyle(PlainListStyle())
                }
            case .error(let message, let showRetry):
                VStack(spacing: 16) {
                    Spacer()
                    Text(message).foregroundColor(.red).multilineTextAlignment(.center).padding(.horizontal)
                    if showRetry {
                        Button("Retry") { presenter.viewDidLoad() }.padding(.top, 4)
                    }
                    Spacer()
                }
            }
        }
        .navigationTitle(presenter.isRemoteList ? "API Contacts" : "Contacts")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                if presenter.isRemoteList {
                    Button("Contacts") { presenter.loadLocalContacts() }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                if !presenter.isRemoteList {
                    Button { presenter.didTapAddContact() } label: { Image(systemName: "plus") }
                }
            }
        }
        .onAppear {
            presenter.view = self
            presenter.viewDidLoad()
        }
        .alert(item: $presenter.activeAlert) { alert in
            switch alert {
            case .success(let msg):
                return Alert(title: Text("Success"), message: Text(msg), dismissButton: .default(Text("OK")))
            case .error(let msg):
                return Alert(title: Text("Error"), message: Text(msg), dismissButton: .default(Text("OK")))
            case .confirmDelete(let contact):
         
                return Alert(title: Text("Confirm"), message: Text("Do you want to delete this contact?"), primaryButton: .destructive(Text("Delete")) {}, secondaryButton: .cancel())
            }
        }
    }
}

extension ContactListView: ContactListViewProtocol {
    func showContacts(_ contacts: [Contact]) {
        self.contacts = contacts
        self.showEmptyMessage = contacts.isEmpty
    }
    
    func showEmptyState() {
        self.contacts = []
        self.showEmptyMessage = true
    }
}
