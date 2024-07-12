//
//  EmergencyView.swift
//  AlertSystem
//
//  Created by Joshua Wenata Sunarto on 12/07/24.
//

import SwiftUI

struct EmergencyView: View {
    // Example emergency contacts
    @State private var emergencyContacts = [
        "test1@test.com",
        "test2@test.com",
        "test3@test.com",
    ]
    @State private var newContactName: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                List {
                    ForEach(emergencyContacts, id: \.self) { contact in
                        Text(contact)
                    }
                    .onDelete(perform: deleteContact)
                }
                .listStyle(GroupedListStyle())
                
                HStack {
                    TextField("Enter new contact email", text: $newContactName)
                        .textFieldStyle(CustomRoundedTextFieldStyle())
                    
                    Button(action: {
                        // Action for adding a new emergency contact
                        // Replace with your logic to add a new contact
                        if !newContactName.isEmpty {
                            emergencyContacts.append(newContactName)
                            newContactName = ""
                        }
                    }) {
                        Text("Add")
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
            }
            .navigationBarTitle("Emergency Contacts")
        }
    }
    
    private func deleteContact(at offsets: IndexSet) {
        emergencyContacts.remove(atOffsets: offsets)
    }
}

struct EmergencyView_Previews: PreviewProvider {
    static var previews: some View {
        EmergencyView()
    }
}
