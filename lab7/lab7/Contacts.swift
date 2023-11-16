import Foundation

struct Contact {
    var firstName: String
    var lastName: String
    var phoneNumber: String
    var email: String
}

func savedContacts() -> [Contact] {
    var contacts = [Contact]()
    
    guard let filepath = Bundle.main.path(forResource: "contacts", ofType: "csv"),
          let contents = try? String(contentsOfFile: filepath) else {
        print("File not found or cannot be read")
        return []
    }
    
    let rows = contents.components(separatedBy: "\n")
    
    for (index, row) in rows.enumerated() {
        if index == 0 { continue }
        
        let columns = row.components(separatedBy: ",")
        if columns.count == 4 {
            let contact = Contact(firstName: columns[0], lastName: columns[1], phoneNumber: columns[2], email: columns[3])
            contacts.append(contact)
        }
    }
    
    return contacts
}

func filteredContacts() -> [Contact] {
    let contacts = savedContacts()
    
    return contacts.filter{contact in
        contact.firstName.starts(with: "J")
    }
}
