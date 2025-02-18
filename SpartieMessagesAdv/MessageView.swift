//
//  MessageView.swift
//  SpartieMessagesAdv
//
//  Created by Ming on 2/14/25.
//

import SwiftUI

struct MessageView: View {
    @State private var newMessage:String = ""
    @EnvironmentObject var viewModel: ViewModel
    let contact: Contact
    
    var body: some View {
        VStack{
            NavigationLink(destination: ProfileView(mode: .edit(contact))){
                ContactProfileHeader(contact: contact)
                    .padding(.top)
            }
            
            
            
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
        
            HStack(alignment: .top){
                Image(contact.photoName ?? "DefaultProfile")
                    .resizable()
                    .frame(width:50, height:50)
                    .clipShape(Circle())
            
                
                VStack(){
                    Text("\(contact.firstName)")
                        .font(.headline)
                        .foregroundStyle(.black)
                    
                    Text("\(contact.lastName)")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                    
                }
                Spacer()
            }
            .padding()
            Spacer()
            
            
        
        
    }
    
}

#Preview {
    MessageView(contact: Contact(firstName: "John", lastName: "Doe", photoName: "DefaultProfile", isFavorite: true))
        .environmentObject(ViewModel())
}
