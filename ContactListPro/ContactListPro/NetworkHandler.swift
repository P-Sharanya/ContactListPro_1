import Foundation

final class NetworkHandler {

    private let apiFetchedKey = "apiContactsFetchedOnce"

  
    func fetchLocalContacts() async -> [Contact] {
        try? await Task.sleep(nanoseconds: 200_000_000)
        return ContactStorage.shared.getAllContacts()
    }

    
    func fetchAPIContacts() async throws -> [Contact] {
        let alreadyFetched = UserDefaults.standard.bool(forKey: apiFetchedKey)

      
        if alreadyFetched {
            return []
        }

        
        let apiURL = URL(string: "https://jsonplaceholder.typicode.com/users")!
        let (data, _) = try await URLSession.shared.data(from: apiURL)
        let decoded = try JSONDecoder().decode([APIContact].self, from: data)

        let mapped = decoded.map {
            Contact(name: $0.name, phone: $0.phone, email: $0.email, isFromAPI: true)
        }

        for contact in mapped {
            try? ContactStorage.shared.addContact(contact)
        }

        UserDefaults.standard.set(true, forKey: apiFetchedKey)

        return mapped
    }
}
