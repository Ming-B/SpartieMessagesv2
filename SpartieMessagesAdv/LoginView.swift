//
//  LoginView.swift
//  SpartieMessagesAdv
//
//  Created by Ming on 2/14/25.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var username:String = ""
    @State var password:String = ""
    @State var hasError:Bool = false
    
    var body: some View{
        VStack {
            Text("Sign In")
                .font(.largeTitle)
                .padding()
            
            TextField("Username", text:$username)
                .padding(12)
                .background(Color(.systemGray6))
                .clipShape(.rect(cornerRadius: 10))
                .textInputAutocapitalization(.never)

            
            SecureField("Password", text:$password)
                .padding(12)
                .background(Color(.systemGray6))
                .clipShape(.rect(cornerRadius: 10))
            
            Button {
                if username == "spartie" && password == "messages" {
                    viewModel.isAuthenticated = true
                }
                else {
                    hasError = true
                }
            } label: {
                Text("Sign In")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width:360, height:44)
                    .background(Color(.systemBlue))
                    .clipShape(.rect(cornerRadius: 10))
                    .padding(.vertical)
            }
            

            
            
        }
        .padding()
        
        if hasError {
            Text("Invalid credentials")
                .foregroundStyle(.red)
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(ViewModel())
    
}
