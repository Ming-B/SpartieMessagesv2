//
//  ProfileView.swift
//  SpartieMessagesAdv
//
//  Created by Ming on 2/14/25.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: ViewModel
    let mode: ProfileMode
    
    @State private var firstName:String
    @State private var lastName:String
    @State private var isFavorite:Bool
    
    init(mode: ProfileMode) {
        self.mode = mode
        if case .edit(let contact) = mode {
            _firstName = State(initialValue: contact.firstName)
            _lastName = State(initialValue: contact.lastName)
            _isFavorite = State(initialValue: contact.isFavorite)
        } else {
            _firstName = State(initialValue: "")
            _lastName = State(initialValue: "")
            _isFavorite = State(initialValue: false)
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Contact Info")) {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                    Toggle("Favorite", isOn: $isFavorite)
                }
            }
            .navigationTitle(mode.title)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveContact()
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func saveContact() {
        switch mode {
        case .add:
            let newContact = Contact(
                firstName: firstName,
                lastName: lastName,
                photoName: nil,
                isFavorite: isFavorite
            )
            viewModel.addContact(newContact)
        case .edit(let existingContact):
            var updatedContact = existingContact
            updatedContact.firstName = firstName
            updatedContact.lastName = lastName
            updatedContact.isFavorite = isFavorite
            viewModel.updateContact(updatedContact)
        }
    }
}

enum ProfileMode {
    case add
    case edit(Contact)
    
    var title: String {
        switch self {
        case .add: return "New Contact"
        case .edit: return "Edit Profile"
        }
    }
}


#Preview {
    ProfileView(mode: .add)
        .environmentObject(ViewModel())
    
}
