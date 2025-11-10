import SwiftUI

struct ContactDetailView: View {
    var contact: Contact
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        VStack(spacing: 16) {
            Text(contact.name)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("📞 \(contact.phone)")
                .font(.title3)
            
            Text("📧 \(contact.email)")
                .font(.title3)
            
            Spacer()
            
            Button(action: {
                router.goBackToList() 
            }) {
                Label("Back to Contacts", systemImage: "arrow.left.circle.fill")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue)
        }
        .padding()
        .navigationTitle("Details")
    }
}

