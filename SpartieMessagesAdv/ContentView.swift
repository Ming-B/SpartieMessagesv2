//
//  ContentView.swift
//  SpartieMessagesAdv
//
//  Created by Ming on 2/14/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel:ViewModel
    @State private var showingAddContact = false
   
    var body: some View {
        NavigationView {
            List(viewModel.contacts) { contact in
                NavigationLink(destination: MessageView(contact: contact)) {
                    ContactRow(contact: contact)
                }
            }
            .navigationTitle("Contacts")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddContact = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddContact) {
                ProfileView(mode: .add)
                    .environmentObject(viewModel)
            }
        }
        .sheet(isPresented: Binding(
            get: { !viewModel.isAuthenticated },
            set: { _ in }
        )) {
            LoginView().environmentObject(viewModel)
        }
    }
}



struct ContactRow:View{
    let contact: Contact
    
    var body: some View{
        HStack{
            Image(contact.photoName ?? "DefaultProfile")
                .resizable()
                .frame(width:50, height:50)
                .clipShape(Circle())
            
            Text(("\(contact.firstName) \(contact.lastName)"))
            Spacer()
            if contact.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow)
            }
                        
            
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ViewModel())
}

