import SwiftUI

struct ContentView: View {
    private var contacts = savedContacts()
    
    var body: some View {
        TabView {
            ContactsView()
                .tabItem { Label( "All contacts", systemImage: "person.crop.circle.fill") }
            FilteredContacts()
                .tabItem { Label( "First name starts with J", systemImage: "person.crop.circle")
                }
        }
    }
}

struct FilteredContacts: View {
    private var contacts = filteredContacts()
    
    var body: some View {
        NavigationView {
            List(contacts, id: \.email) { contact in
                ContactRow(contact: contact)
            }
            .navigationBarTitle("Contacts")
            .listStyle(GroupedListStyle())
        }
    }
}


struct ContactsView: View {
    private var contacts = savedContacts()
    
    var body: some View {
        NavigationView {
            List(contacts, id: \.email) { contact in
                ContactRow(contact: contact)
            }
            .navigationBarTitle("Contacts")
            .listStyle(GroupedListStyle())
        }
    }
}

struct ContactRow: View {
    var contact: Contact
    
    var body: some View {
        HStack {
            Image(systemName: "person.crop.circle.fill")
                .font(.largeTitle)
                .foregroundColor(.blue)
                .padding(.trailing, 10)
            
            VStack(alignment: .leading) {
                Text("\(contact.firstName) \(contact.lastName)")
                    .font(.headline)
                Text(contact.phoneNumber)
                    .font(.subheadline)
                Text(contact.email)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 8)
    }
}


#Preview {
    ContentView()
}
