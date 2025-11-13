

#  ContactListPro

**ContactListPro** is a SwiftUI-based iOS application that follows the **VIPER architecture pattern** to manage contacts efficiently.

The project uses **modular architecture** for clear separation of concerns and easy scalability.

`Modules` define separate VIPER components for each screen (List, Add, Detail).

`Storage` uses **UserDefaults** through the `ContactStorage` class to persist user data locally.

`AppCompositionRoot` builds and injects dependencies, setting up the app’s root navigation controller.

`ContactListProApp` acts as the entry point for the SwiftUI app.

`NetworkHandler` simulates fetching contacts asynchronously.

`RootViewControllerWrapper` bridges UIKit controllers with SwiftUI views, ensuring a smooth navigation experience across the app.

---

* **Modules** → Break down features (Contact List, Add Contact, Contact Detail) into smaller VIPER components for better organization, reusability, and testing.
* **Storage** → The `ContactStorage` class handles CRUD operations using **UserDefaults** for offline data persistence.
* **AppCompositionRoot** → Creates and connects the root view controller and initial navigation flow for the entire app.
* **ContactListProApp** → SwiftUI’s main application structure; integrates UIKit components inside a SwiftUI lifecycle.
* **NetworkHandler** → Simulates contact retrieval from a backend, mimicking asynchronous network behavior for realism.
* **RootViewControllerWrapper** → Wraps UIKit’s `UINavigationController` in SwiftUI using `UIViewControllerRepresentable`, enabling UIKit navigation in a SwiftUI app.

---

##  Screen 1 – Contact List


The **Contact List** screen displays all saved contacts in a clean SwiftUI list format. If no contacts are available, an empty state message encourages users to add new ones. Users can tap the **“+”** icon to add new contacts or select an existing contact to view details.

<img width="264" height="578" alt="Screenshot 2025-11-13 at 7 01 42 PM" src="https://github.com/user-attachments/assets/a8c42c50-bc50-49a0-82f8-5acb8723e13c" />
<img width="269" height="579" alt="Screenshot 2025-11-13 at 7 00 30 PM" src="https://github.com/user-attachments/assets/d3d34d93-4adf-40db-97e6-c8f264103b64" />


**VIPER flow :**

1. `ContactListView` displays the list and handles user interactions (like add or select).
2. `ContactListPresenter` coordinates between the view and interactor, triggering data fetch on load.
3. `ContactListInteractor` fetches contacts through `NetworkHandler`.
4. `NetworkHandler` retrieves stored data from `ContactStorage` asynchronously.
5. `ContactListRouter` manages navigation to `AddContactBuilder` or `ContactDetailBuilder`.
6. `ContactListBuilder` connects all components and injects dependencies into the module.

---

##  Screen 2 – Add Contact

The **Add Contact** screen allows users to create new contacts by entering name, phone, and email information. The fields are validated for correctness, and visual indicators highlight invalid inputs. Upon saving, the contact is stored locally using `UserDefaults`, and the app returns to the main contact list.

<img width="271" height="572" alt="Screenshot 2025-11-13 at 7 01 53 PM" src="https://github.com/user-attachments/assets/ac14c477-0925-4b00-b055-aa36479b2428" />
<img width="267" height="573" alt="Screenshot 2025-11-13 at 7 02 03 PM" src="https://github.com/user-attachments/assets/40b36709-94de-41f6-bf62-e879b39ecc8d" />
<img width="272" height="578" alt="Screenshot 2025-11-13 at 7 02 18 PM" src="https://github.com/user-attachments/assets/30f49a1e-dd05-41f6-bfcb-1ea097776917" />
<img width="274" height="574" alt="Screenshot 2025-11-13 at 7 02 57 PM" src="https://github.com/user-attachments/assets/e7f05733-9ab6-4474-8e46-7abb3625bd29" />
<img width="276" height="580" alt="Screenshot 2025-11-13 at 7 03 28 PM" src="https://github.com/user-attachments/assets/fabb5b26-e5ca-4a2e-9b6f-f008fd410592" />
<img width="253" height="574" alt="Screenshot 2025-11-13 at 7 03 46 PM" src="https://github.com/user-attachments/assets/06c0f3c0-04ab-49f1-8b11-9c0c84723c35" />



**VIPER flow :**

1. `AddContactView` collects user input and forwards actions to the presenter.
2. `AddContactPresenter` performs field validation and passes valid data to the interactor.
3. `AddContactInteractor` creates a new `Contact` and saves it via `ContactStorage`.
4. `AddContactRouter` handles dismissing the view or navigation back to the contact list.
5. `AddContactBuilder` builds and wires together the interactor, presenter, router, and SwiftUI view.

---

##  Screen 3 – Contact Detail


The **Contact Detail** screen shows detailed information about a selected contact, including name, phone, and email. Users can edit details or delete the contact. Any update or deletion is reflected immediately in the list through persistent storage managed by `ContactStorage`.

<img width="272" height="570" alt="Screenshot 2025-11-13 at 7 00 40 PM" src="https://github.com/user-attachments/assets/0b6cb952-b021-4e9b-a84f-e81cf53183fa" />
<img width="256" height="571" alt="Screenshot 2025-11-13 at 7 00 56 PM" src="https://github.com/user-attachments/assets/40d199a3-28b3-4612-9277-56a085ac7554" />
<img width="266" height="576" alt="Screenshot 2025-11-13 at 7 01 10 PM" src="https://github.com/user-attachments/assets/763bbab3-d02d-46e1-9081-f086660010b4" />



**VIPER flow :**

1. `ContactDetailView` displays the contact information and provides edit/delete actions.
2. `ContactDetailPresenter` validates updates and triggers interactor functions for edit or delete operations.
3. `ContactDetailInteractor` updates or removes the contact in `ContactStorage`.
4. `ContactDetailRouter` navigates back to the contact list after successful action.
5. `ContactDetailBuilder` initializes all VIPER components and injects the selected contact into the module.

---

**Tech Summary**

* **Framework:** SwiftUI + UIKit integration
* **Architecture:** VIPER
* **Local Storage:** UserDefaults (via `ContactStorage`)
* **Language:** Swift
* **Navigation:** `UINavigationController` embedded through SwiftUI wrapper
* **Data Handling:** Simulated asynchronous fetching with `NetworkHandler`

---

**Key Features**

* Modular VIPER structure for scalability
* Local persistence using UserDefaults
* Clean separation between logic and UI
* Add, Edit, Delete, and View contact functionalities
* Smooth navigation using UIKit wrapped in SwiftUI


