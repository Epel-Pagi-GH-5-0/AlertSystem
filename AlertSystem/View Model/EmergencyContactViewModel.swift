//
//  EmergencyContactViewModel.swift
//  AlertSystem
//
//  Created by Romi Fadhurohman Nabil on 12/07/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class EmergencyContactViewModel: ObservableObject {
    private var db = Firestore.firestore()
    
    func getEmergencyContacts(forUserId userId: String, completion: @escaping ([EmergencyContact]) -> Void) {
            let userRef = db.collection("users").document(userId)
            userRef.collection("emergencyContacts").getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error getting emergency contacts: \(error.localizedDescription)")
                    completion([])
                    return
                }
                
                let contacts = snapshot?.documents.compactMap { document in
                    try? document.data(as: EmergencyContact.self)
                } ?? []
                completion(contacts)
            }
        }
}
