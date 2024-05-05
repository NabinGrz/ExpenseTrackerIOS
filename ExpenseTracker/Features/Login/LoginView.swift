//
//  LoginView.swift
//  ExpenseTracker
//
//  Created by Nabin Gurung on 29/04/2024.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
  @State private  var viewModel : LoginViewModel = LoginViewModel()
    
    var body: some View {
//        viewModel.typing.
        
        VStack {
            Text("\(viewModel.typing ? "Typing":"---")")
            Form {
                HStack {
                    TextField("Email", text: $viewModel.email)  { textfield in
                        viewModel.userTyping(typing: true)
                    }
                        .autocorrectionDisabled()
                    .autocapitalization(.none)
                    
                    Button{
                        viewModel.userTyping(typing: false)
                    }label: {
                        Text("Send")
                    }
                }
                SecureField("Password", text: $viewModel.password)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
            }
            
            Button{
                Task {
                    viewModel.signup()
                }
            }label: {
                viewModel.isLogging ? Text("Signing") :  Text("Sign up")
            }
            
            Button{
                Task {
                    viewModel.login()
                }
            }label: {
                viewModel.isLogging ? Text("Logging") :  Text("Login")
            }
        }
        .task {
            viewModel.listenTyping()
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
    }
}

#Preview {
    LoginView()
}
