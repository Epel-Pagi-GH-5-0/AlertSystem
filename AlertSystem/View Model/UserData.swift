//
//  User.swift
//  AlertSystem
//
//  Created by Romi Fadhurohman Nabil on 12/07/24.
//

import Foundation
import FirebaseFirestoreSwift

struct UserData: Identifiable, Codable {
    @DocumentID var id: String? // Firestore document ID
    var username: String
    var email: String
    var phone: String
    var gender: String
    var password: String
    var emergencyContacts: [EmergencyContact]?
}
