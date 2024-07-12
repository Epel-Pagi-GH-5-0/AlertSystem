//
//  UserViewModel.swift
//  AlertSystem
//
//  Created by Romi Fadhurohman Nabil on 12/07/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import CryptoKit

class UserDataViewModel: ObservableObject {
    @Published var user: UserData? = nil
    @Published var errorMessage: String? = nil
    private var db = Firestore.firestore()
    
    func addUser(_ user: UserData, emergencyContacts: [EmergencyContact]) {
        // Check if the email is already in use
        db.collection("users").whereField("email", isEqualTo: user.email).getDocuments { (snapshot, error) in
            if let error = error {
                self.errorMessage = "Error checking email: \(error.localizedDescription)"
                return
            }
            
            if let snapshot = snapshot, !snapshot.isEmpty {
                // Email already exists
                self.errorMessage = "Email already in use."
            } else {
                // Email is unique, proceed with adding user
                do {
                    // Hash the password before storing
                    var userToStore = user
                    userToStore.password = hashPassword(user.password)
                    
                    let userRef: DocumentReference
                    if let id = user.id {
                        userRef = self.db.collection("users").document(id)
                        try userRef.setData(from: userToStore)
                    } else {
                        userRef = try self.db.collection("users").addDocument(from: userToStore)
                    }
                    
                    // Add emergency contacts to subcollection
                    for contact in emergencyContacts {
                        let _ = try userRef.collection("emergencyContacts").document(contact.id.uuidString).setData(from: contact)
                    }
                    
                    self.errorMessage = nil // Clear error message on success
                } catch let error {
                    self.errorMessage = "Error writing user to Firestore: \(error.localizedDescription)"
                }
            }
        }
    }
    
}
