//
//  EmergencyContact.swift
//  AlertSystem
//
//  Created by Romi Fadhurohman Nabil on 12/07/24.
//

import Foundation

struct EmergencyContact: Identifiable, Codable {
    var id: UUID
    var name: String
    var email: String
    var phone: String
}
