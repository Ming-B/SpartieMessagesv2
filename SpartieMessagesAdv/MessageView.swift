//
//  MessageView.swift
//  SpartieMessagesAdv
//
//  Created by Ming on 2/14/25.
//

import SwiftUI

struct MessageView: View {
    let contact: Contact
    @State private var newMessage:String = ""
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        VStack{
            
            ContactProfileHeader(contact: contact)
                .padding(.top)
            
            List(contact.messages) { message in
                HStack{
                    Spacer()
                    VStack(alignment: .trailing){
                        Text(message.content)
                            .padding()
                            .background(Color.blue)
                            .foregroundStyle(.white)
                            .clipShape(.rect(cornerRadius: 20))
                            
                        
                        Text(getDateFormat(date:message.date))
                            .font(.caption)
                            .foregroundStyle(.gray)
                        
                    }
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                
            }
            .listStyle(.plain)
        }
        
        HStack{
            TextField("Message", text:$newMessage)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onSubmit{
                    sendMessage()
                }
            
            Button(action: sendMessage){
                Image(systemName: "paperplane")
                
            }
            .padding()
        }
        .navigationTitle("Messages")
        
    }
    
    private func sendMessage(){
        guard !newMessage.isEmpty else {
            return
        }
        
        let message = Message(content: newMessage)
        
        viewModel.addMessage(message, to: contact)
        newMessage = ""
    }
}


struct ContactProfileHeader: View {
    let contact:Contact
    
    var body: some View {
        HStack{
            Image(contact.photoName ?? "DefaultProfile")
                .resizable()
                .frame(width:50, height:50)
                .clipShape(Circle())
            
            VStack(alignment: .leading){
                Text("\(contact.firstName)")
                    .font(.headline)
                
                Text("\(contact.lastName)")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
        }
        .padding()
    }
    
}

#Preview {
    MessageView(contact: Contact(firstName: "John", lastName: "Doe", photoName: "DefaultProfile", isFavorite: true))
        .environmentObject(ViewModel())
}
