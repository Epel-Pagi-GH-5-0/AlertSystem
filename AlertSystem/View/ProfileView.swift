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
            List {
                Section(header: Text("Personal Information").foregroundColor(.black)) {
                    NavigationLink(destination: UserDataView()) {
                        HStack {
                            Text("User Data (Required)")
                            Spacer()
                            Text("Not set")
                        }
                    }
                    NavigationLink(destination: EmergencyView()) {
                        HStack {
                            Text("Emergency Contact (Required)")
                            Spacer()
                            Text("Not set")
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .background(Color.clear)
            .padding() // Optional: Add padding around the list
        }
        .padding()
        .background(Color.background) // Set VStack background explicitly to white
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
