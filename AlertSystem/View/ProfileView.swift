//
//  ProfileView.swift
//  AlertSystem
//
//  Created by Joshua Wenata Sunarto on 12/07/24.
//

import SwiftUI

struct ProfileView: View {
    // Example emergency contacts
    let emergencyContacts = [
        "Emergency Contact 1",
        "Emergency Contact 2",
        "Emergency Contact 3"
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 10) {
                NavigationLink(destination: {
                    UserDataView()
                }, label: {
                    Text("User Data (Required)")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                })
                
                
                NavigationLink(destination: {
                    EmergencyView()
                }, label: {
                    Text("Emergency Contact (Required)")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                })
            }
            
            Divider() // Adds a divider between buttons and emergency contacts
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Emergency Contacts:")
                    .font(.headline)
                    .padding(.bottom, 5)
                
                ForEach(emergencyContacts, id: \.self) { contact in
                    Text(contact)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
        }
        .padding()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
