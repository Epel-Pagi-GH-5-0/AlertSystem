//
//  HashPassword.swift
//  AlertSystem
//
//  Created by Romi Fadhurohman Nabil on 12/07/24.
//

import Foundation
import CryptoKit

func hashPassword(_ password: String) -> String {
    let inputData = Data(password.utf8)
    let hashed = SHA256.hash(data: inputData)
    return hashed.compactMap { String(format: "%02x", $0) }.joined()
}
