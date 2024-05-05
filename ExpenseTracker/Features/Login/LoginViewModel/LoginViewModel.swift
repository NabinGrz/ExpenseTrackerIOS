//
//  LoginViewModel.swift
//  ExpenseTracker
//
//  Created by Nabin Gurung on 29/04/2024.
//

import Foundation
import Firebase
import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

@Observable final class LoginViewModel {
    
    let db = Firestore.firestore()
    
    var typing: Bool = false
    var email = "nobig22@gmail.com"
    var password = "Admin@123"
    var isLogging = false
    var showAlert = false
    
    let auth = Auth.auth()
    var alertItem: AlertItem? = nil
    
    func login() {
        isLogging = true
        auth.signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                self.alertItem = AlertItem(title: Text("Login Failed"),message: Text("\(error?.localizedDescription ?? "Something went wrong")"), dismissButton:   .default(Text("OK")))
            } else {
                self.alertItem = AlertItem(title: Text("Login Success"),message: Text("Successfully logged in"), dismissButton:   .default(Text("OK")))
            }
        }
        isLogging = false
    }
    
    func signup() {
        isLogging = true
        auth.createUser(withEmail: email, password: password) { (result, error) in
            if error != nil {
                self.alertItem = AlertItem(title: Text("Signup Failed"),message: Text("\(error?.localizedDescription ?? "Something went wrong")"), dismissButton:   .default(Text("OK")))
            } else {
                self.alertItem = AlertItem(title: Text("Signup Success"),message: Text("Successfully created user"), dismissButton:   .default(Text("OK")))
            }
        }
        isLogging = false
    }
    
    
    
    
    
    func userTyping(typing: Bool){
        let docRef = db.collection("typing").document("v9BtQTiTaoezdwyYvnM7")
        docRef.setData([
            "isTyping": typing,
        ], merge: true){error in
            if let error = error {
                print("Error writing document: \(error)")
            } else {
                print("Document successfully merged!")
            }
        }
    }
    
    func listenTyping(){
        let docRef = db.collection("typing").document("v9BtQTiTaoezdwyYvnM7")
        docRef.addSnapshotListener { (snapshot, error) in
            self.typing = snapshot?.data()?["isTyping"] as? Bool ?? false
        }
    }
}

