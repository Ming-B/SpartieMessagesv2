//
//  Models.swift
//  SpartieMessagesAdv
//
//  Created by Ming on 2/14/25.
//

import Foundation

struct Contact: Identifiable {
    let id = UUID()
    var firstName: String
    var lastName: String
    var photoName: String?
    var isFavorite: Bool
    var messages: [Message] = []
}

struct Message : Identifiable {
    let id = UUID()
    var content:String
    let date = Date()
    
    init(content: String) {
        self.content = content
    }
    
}

func getDateFormat(date:Date) -> String{
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateStyle = .short
    dateFormatter.timeStyle = .short
    dateFormatter.locale = Locale(identifier: "en_US")
    
    return dateFormatter.string(from: date)
}

class ViewModel: ObservableObject {
    @Published var contacts: [Contact] = []
    @Published var isAuthenticated = false
    
    init() {
        contacts = [
            Contact(firstName: "Peter", lastName: "Parker", photoName: "ProfilePhoto2", isFavorite: true),
            Contact(firstName: "Doraemon", lastName: "Jones", photoName: "ProfilePhoto1", isFavorite: true),
            Contact(firstName: "Charlie", lastName: "Brown", photoName: "DefaultProfile", isFavorite: false)
        ]
    }
    
    
    func addContact(_ contact: Contact) {
        contacts.append(contact)
    }
    
    func updateContact(_ updatedContact: Contact) {
        if let index = contacts.firstIndex(where: { $0.id == updatedContact.id }) {
            contacts[index] = updatedContact
        }
    }
    
    func addMessage(_ message: Message, to contact: Contact) {
        if let index = contacts.firstIndex(where: { $0.id == contact.id }) {
            contacts[index].messages.append(message)

        }
    }
}
