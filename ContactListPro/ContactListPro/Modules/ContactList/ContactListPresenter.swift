import Foundation

final class ContactListPresenter: ObservableObject, ContactListPresenterProtocol {
    
    @Published var loadingState: LoadingStates = .idle
    @Published var activeAlert: AppAlert?
    @Published var contacts: [Contact] = []
    @Published var isRemoteList = false
    
    var view: ContactListViewProtocol?
    private let interactor: ContactListInteractorProtocol
    private let router: ContactListRouterProtocol
    
    private var apiContacts: [Contact] = []
    private var localContacts: [Contact] = []
    
    init(interactor: ContactListInteractorProtocol, router: ContactListRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    // MARK: - Sorting Helper
    private func sortMerged(_ contacts: [Contact]) -> [Contact] {
        contacts.sorted { a, b in
            if a.isFromAPI == b.isFromAPI {
                return a.name.lowercased() < b.name.lowercased()
            }
            return a.isFromAPI == false           }
    }
    
    // MARK: - Entry
    func viewDidLoad() {
        loadingState = .idle
        Task {
          
            try? await Task.sleep(nanoseconds: 200_000_000)
            let placeholders = Array(repeating: Contact(name: "Loading...", phone: "------", email: "-----"), count: 6)
            await MainActor.run {
                self.loadingState = .loading(placeholders)
            }
         
            do {
                let fetchedAPI = try await interactor.fetchAPIContacts()
                await MainActor.run {
                    self.apiContacts = fetchedAPI.map {
                        var c = $0
                        c.isFromAPI = true
                        return c
                    }
                    self.contacts = self.apiContacts
                    self.loadingState = .loaded(self.contacts)
                }
            } catch {
                await MainActor.run {
                    self.loadingState = .error("Failed to load API contacts.", true)
                }
            }
            
            let local = await interactor.fetchLocalContacts()
            await MainActor.run {
                self.localContacts = local
                var merged: [Contact] = []
                merged.append(contentsOf: self.localContacts)
                let apiFiltered = self.apiContacts.filter { api in
                    !self.localContacts.contains(where: { $0.id == api.id })
                }
                merged.append(contentsOf: apiFiltered)
                let sorted = self.sortMerged(merged)
                self.contacts = sorted
                self.loadingState = .loaded(sorted)
                if sorted.isEmpty {
                    self.view?.showEmptyState()
                } else {
                    self.view?.showContacts(sorted)
                }
            }
        }
    }
    
    // MARK: - Toolbar behavior / actions
    func didTapAPIContacts() {
        isRemoteList = true
        viewDidLoad()
    }
    
    func loadLocalContacts() {
        isRemoteList = false
        Task {
            let local = await interactor.fetchLocalContacts()
            await MainActor.run {
                self.localContacts = local
                var merged: [Contact] = []
                merged.append(contentsOf: self.localContacts)
                merged.append(contentsOf: self.apiContacts.filter { api in
                    !self.localContacts.contains(where: { $0.id == api.id })
                })
                let sorted = self.sortMerged(merged)
                self.contacts = sorted
                self.loadingState = .loaded(sorted)
                if sorted.isEmpty {
                    self.view?.showEmptyState()
                } else {
                    self.view?.showContacts(sorted)
                }
            }
        }
    }
    
    // MARK: - Navigation to detail
    func didSelectContact(_ contact: Contact) {
        let detailInteractor = ContactDetailInteractor()
        let detailRouter = ContactDetailRouter()
        detailRouter.navigationController = router.navigationController
        let detailPresenter = ContactDetailPresenter(
            contact: contact,
            interactor: detailInteractor,
            router: detailRouter,
            refreshListCallback: { [weak self] in
                await self?.refreshAfterDelete()
            }
        )
        router.navigationToContactDetail(presenter: detailPresenter)
    }

    func didTapAddContact() {
        router.navigationToAddContacts()
    }
    
    // MARK: - Refresh flows
    func refreshAfterAdd() {
        Task {
            let local = await interactor.fetchLocalContacts()
            await MainActor.run {
                self.localContacts = local
                var merged: [Contact] = []
                merged.append(contentsOf: self.localContacts)
                merged.append(contentsOf: self.apiContacts.filter { api in
                    !self.localContacts.contains(where: { $0.id == api.id })
                })
                let sorted = self.sortMerged(merged)
                self.contacts = sorted
                self.loadingState = .loaded(sorted)
                if sorted.isEmpty { self.view?.showEmptyState() }
                else { self.view?.showContacts(sorted) }
            }
        }
    }
    
    func refreshAfterDelete() async {
        let local = await interactor.fetchLocalContacts()
        await MainActor.run {
            self.localContacts = local
            var merged: [Contact] = []
            merged.append(contentsOf: self.localContacts)
            merged.append(contentsOf: self.apiContacts.filter { api in
                !self.localContacts.contains(where: { $0.id == api.id })
            })
            let sorted = self.sortMerged(merged)
            self.contacts = sorted
            self.loadingState = .loaded(sorted)
            if sorted.isEmpty { self.view?.showEmptyState() }
            else { self.view?.showContacts(sorted) }
        }
    }
}
