

#  ContactListPro

**ContactListPro** is a SwiftUI-based iOS application that follows the **VIPER architecture pattern** for UI, UIKit hosting controllers for navigation, VIPER architecture for modularity, UserDefaults for persistent storage, and URLSession for fetching API contacts.

The project uses **modular architecture** for clear separation of concerns and easy scalability.

`Modules` define separate VIPER components for each screen (List, Add, Detail).

`Storage` uses **UserDefaults** through the `ContactStorage` class to persist user data locally.

`AppCompositionRoot` builds and injects dependencies, setting up the app’s root navigation controller.

`NetworkHandler` simulates fetching contacts asynchronously.

`AppDelegate` sets up the initial UI and application lifecycle, loading the root module.

---

* **Modules** → Break down features (Contact List, Add Contact, Contact Detail) into smaller VIPER components for better organization, reusability, and testing.
* **Storage** → The `ContactStorage` class handles CRUD operations using **UserDefaults** for offline data persistence.
* **AppCompositionRoot** → Creates and connects the root view controller and initial navigation flow for the entire app.
* **ContactListProApp** → SwiftUI’s main application structure; integrates UIKit components inside a SwiftUI lifecycle.
* **NetworkHandler** → Simulates contact retrieval from a backend, mimicking asynchronous network behavior for realism.
* **RootViewControllerWrapper** → Wraps UIKit’s `UINavigationController` in SwiftUI using `UIViewControllerRepresentable`, enabling UIKit navigation in a SwiftUI app.

---

##  Screen 1 – Contact List


The **Contact List** screen displays locally saved contacts or API contacts in a clean SwiftUI list format. If no contacts are available, an empty state message encourages users to add new ones. Users can tap the **“+”** icon to add new contacts or select an existing contact to view details.

<img width="200" alt="Simulator Screen Shot - iPhone 14 Pro - 2025-11-18 at 13 48 43" src="https://github.com/user-attachments/assets/e25af337-f387-4548-bc6e-749709ad9acd" />
<img width="200" alt="Simulator Screen Shot - iPhone 14 Pro - 2025-11-18 at 13 50 49" src="https://github.com/user-attachments/assets/2ab97f28-f14f-4210-8c52-3d063c17c26f" />
<img width="200" alt="Simulator Screen Shot - iPhone 14 Pro - 2025-11-18 at 13 48 50" src="https://github.com/user-attachments/assets/047a84c6-2b07-429f-a6c0-cda2e07e0004" />
<img width="200" alt="Simulator Screen Shot - iPhone 14 Pro - 2025-11-18 at 13 48 55" src="https://github.com/user-attachments/assets/191333bc-5f0a-49c7-b561-7593833e12f6" />


**VIPER flow :**

1. `ContactListBuilder` connects all components and injects dependencies into the module.
2. `ContactListView` displays the list and handles user interactions (like add or select).
3. `ContactListPresenter` coordinates between the view and interactor, triggering data fetch on load.
4. `ContactListInteractor` fetches API contacts via URLSession, and local contacts directly from `ContactStorage`.
5. `NetworkHandler` retrieves stored data from `ContactStorage` asynchronously.
6. `ContactListRouter` manages navigation to `AddContactBuilder` for adding new contact or `ContactDetailBuilder` for viewing or editing the contact.

---

##  Screen 2 – Add Contact

The **Add Contact** screen allows users to create new contacts by entering name, phone, and email information with validation handled in the presenter. The form uses SwiftUI with alert messaging when invalid inputs entered. When saved, the new contact is stored locally using `UserDefaults`, and the app returns to the main contact list and the list refreshes using a callback.


<img width="200" alt="Simulator Screen Shot - iPhone 14 Pro - 2025-11-18 at 13 49 06" src="https://github.com/user-attachments/assets/8d428b5e-7e6a-45e4-8c09-71615d29bbbb" />
<img width="200" alt="Simulator Screen Shot - iPhone 14 Pro - 2025-11-18 at 13 49 19" src="https://github.com/user-attachments/assets/507f672d-76a9-455b-bb60-0f5efbbbb269" />
<img width="200" alt="Simulator Screen Shot - iPhone 14 Pro - 2025-11-18 at 13 49 45" src="https://github.com/user-attachments/assets/1fa7494d-25b4-4d55-b924-d30b98297270" />
<img width="200" alt="Simulator Screen Shot - iPhone 14 Pro - 2025-11-18 at 13 49 58" src="https://github.com/user-attachments/assets/37d7991a-2b82-4d07-aeb8-67e9f3d05a87" />
<img width="200" alt="Simulator Screen Shot - iPhone 14 Pro - 2025-11-18 at 13 50 26" src="https://github.com/user-attachments/assets/7c94dd3f-844d-4843-99d2-dd21abc2297c" />
<img width="200" alt="Simulator Screen Shot - iPhone 14 Pro - 2025-11-18 at 13 50 41" src="https://github.com/user-attachments/assets/70830a6b-ec41-46e3-9894-49b0b4b3fba4" />


**VIPER flow :**

1. `AddContactBuilder` constructs the view, presenter, interactor, and router.
2. `AddContactView` collects user input and forwards actions to the presenter.
3. `AddContactPresenter` performs field validation and passes valid data to the interactor.
4. `AddContactInteractor` creates a new `Contact` and saves it via `ContactStorage`.
5. `AddContactRouter` handles dismissing the view or navigates back to the contact list.


---

##  Screen 3 – Contact Detail


The **Contact Detail** screen shows detailed information about a selected contact, including name, phone, and email. Users can edit details or delete the local contacts, while API contacts remain read-only. The screen toggles between read and edit modes through SwiftUI.  Any update or deletion is reflected immediately in the list through persistent storage managed by `ContactStorage`.

<img width="200" alt="Simulator Screen Shot - iPhone 14 Pro - 2025-11-18 at 13 50 54" src="https://github.com/user-attachments/assets/56620f6b-31bc-4f5a-b000-d9705472ec3c" />
<img width="200" alt="Simulator Screen Shot - iPhone 14 Pro - 2025-11-18 at 15 13 00" src="https://github.com/user-attachments/assets/5e437c09-05f4-43d8-8502-9640eea9e334" />
<img width="200" alt="Simulator Screen Shot - iPhone 14 Pro - 2025-11-18 at 13 51 02" src="https://github.com/user-attachments/assets/3ed50cb1-3ac0-467f-b92d-da3853348a63" />
<img width="200" alt="Simulator Screen Shot - iPhone 14 Pro - 2025-11-18 at 15 13 20" src="https://github.com/user-attachments/assets/25b27122-4e3e-444e-9468-cf3804ccdc8d" />
<img width="200" alt="Simulator Screen Shot - iPhone 14 Pro - 2025-11-18 at 15 13 34" src="https://github.com/user-attachments/assets/e7cf4baf-1231-42d8-9beb-5590108daf47" />
<img width="200" alt="Simulator Screen Shot - iPhone 14 Pro - 2025-11-18 at 15 13 51" src="https://github.com/user-attachments/assets/bc4fb977-3894-4a5d-8cdd-6e06a181ae81" />


**VIPER flow :**

1. `ContactDetailBuilder` creates the module and determines if the contact is local or API-based.
2. `ContactDetailView` displays or edits contact fields.
3. `ContactDetailPresenter` validates edits or triggers deletion.
4. `ContactDetailInteractor` updates or removes data via ContactStorage.
5. `ContactDetailRouter` navigates back after operations.

---

**Tech Summary**

* **Framework:** SwiftUI + UIKit integration
* **Architecture:** VIPER
* **Local Storage:** UserDefaults (via `ContactStorage`)
* **Language:** Swift
* **Navigation:** `UINavigationController` through hosting controllers
* **Data Handling:** Simulated asynchronous fetching with `NetworkHandler` and API calls via `URLSession`

---

**Key Features**

* Entire UI is built using SwiftUI, modularized with VIPER.
* Modular VIPER structure for scalability
* Local persistence using UserDefaults
* Clean separation between logic and UI
* Add, Edit, Delete, and View contact functionalities
* API contacts come from "jsonplaceholder.typicode.com"
* Navigation uses UIKit UINavigationController wrapped in hosting controllers.
---
