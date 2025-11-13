# ContactListPro

I created this iOS project using SwiftUI and follows the VIPER architecture pattern for the Contact List. The app uses UserDefaults for local storage to save and retrieve contact details persistently. This structure keeps logic centralized, improves testability, and makes the flow modular and easy to maintain.

Modules: Each feature (like ContactList, ContactDetail, AddContact) is a self-contained module to separate logic, UI, and navigation.

App: The ContactListProApp.swift file is the entry point that initializes and displays the main module (ContactListView).

Storage: The ContactStorage.swift file manages saving, retrieving, and deleting contact data using UserDefaults, keeping persistence logic separate from UI.

Entities: The Contact.swift file defines the contact data model (id, name, phone, email) used throughout the app, ensuring consistent data structure.

## Screen 1 — Contact List Screen

The Contact List screen displays all stored contacts fetched from UserDefaults. It allows adding, selecting, or deleting contacts. The screen uses a SwiftUI List showing names and phone numbers, with an “Add”(+) button in the navigation bar for creating new contacts.


<img width="264" height="578" alt="Screenshot 2025-11-13 at 7 01 42 PM" src="https://github.com/user-attachments/assets/a8c42c50-bc50-49a0-82f8-5acb8723e13c" />
<img width="269" height="579" alt="Screenshot 2025-11-13 at 7 00 30 PM" src="https://github.com/user-attachments/assets/d3d34d93-4adf-40db-97e6-c8f264103b64" />
<img width="272" height="570" alt="Screenshot 2025-11-13 at 7 00 40 PM" src="https://github.com/user-attachments/assets/0b6cb952-b021-4e9b-a84f-e81cf53183fa" />
<img width="256" height="571" alt="Screenshot 2025-11-13 at 7 00 56 PM" src="https://github.com/user-attachments/assets/40d199a3-28b3-4612-9277-56a085ac7554" />
<img width="266" height="576" alt="Screenshot 2025-11-13 at 7 01 10 PM" src="https://github.com/user-attachments/assets/763bbab3-d02d-46e1-9081-f086660010b4" />
<img width="271" height="572" alt="Screenshot 2025-11-13 at 7 01 53 PM" src="https://github.com/user-attachments/assets/ac14c477-0925-4b00-b055-aa36479b2428" />
<img width="267" height="573" alt="Screenshot 2025-11-13 at 7 02 03 PM" src="https://github.com/user-attachments/assets/40b36709-94de-41f6-bf62-e879b39ecc8d" />
<img width="272" height="578" alt="Screenshot 2025-11-13 at 7 02 18 PM" src="https://github.com/user-attachments/assets/30f49a1e-dd05-41f6-bfcb-1ea097776917" />
<img width="274" height="574" alt="Screenshot 2025-11-13 at 7 02 57 PM" src="https://github.com/user-attachments/assets/e7f05733-9ab6-4474-8e46-7abb3625bd29" />
<img width="276" height="580" alt="Screenshot 2025-11-13 at 7 03 28 PM" src="https://github.com/user-attachments/assets/fabb5b26-e5ca-4a2e-9b6f-f008fd410592" />
<img width="253" height="574" alt="Screenshot 2025-11-13 at 7 03 46 PM" src="https://github.com/user-attachments/assets/06c0f3c0-04ab-49f1-8b11-9c0c84723c35" />


 ### VIPER Flow :

-	ContactListRouter builds and connects ContactListView, ContactListPresenter, ContactListInteractor, and ContactEntity.

-	ContactListView appears and calls ContactListPresenter to fetch data.


-	ContactListPresenter communicates with ContactListInteractor to get data from ContactStorage.

-	ContactListInteractor retrieves stored contacts from UserDefaults and passes them to ContactListPresenter, which updates ContactListView with the formatted list.

-	Selecting or adding contacts triggers navigation through ContactListRouter.

## Screen 2 — Add Contact Screen

The Add Contact screen is a SwiftUI form for entering new contact details (name, phone, email). It doesn’t have a separate VIPER module; it uses logic from the ContactListInteractor for saving data and communicates back through the ContactListPresenter to refresh the list.



### Working:

-	AddContactView collects user input and creates a new ContactEntity.

-	It calls ContactListInteractor to save the new contact into UserDefaults via ContactStorage.

-	Once saved, the ContactListPresenter is informed to refresh the list.

-	The screen dismisses and returns to ContactListView, showing the updated contacts.

## Screen 3 — Contact Detail Screen

The Contact Detail screen displays a single contact’s full information. It relies on the ContactList VIPER structure to manage adding and deletions, ensuring all data modifications go through the same Interactor and Presenter layers.



### Working:

-	ContactListView passes the selected ContactEntity to ContactDetailView.

-	ContactDetailView displays the data and, if deleted, communicates with ContactListInteractor.

-	ContactListInteractor removes the record in UserDefaults using ContactStorage.

-	The ContactListPresenter refreshes ContactListView with the latest data when returning.




