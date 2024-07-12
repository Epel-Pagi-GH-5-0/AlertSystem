//
//  UserDataView.swift
//  AlertSystem
//
//  Created by Joshua Wenata Sunarto on 12/07/24.
//

import SwiftUI
import UIKit

struct UserDataView: View {
    // State variables to store user input
    @State private var fullName = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var gender = Gender.male // Default selection
    @State private var selectedImage: UIImage? = nil // For storing selected photo
    @State private var showImagePicker = false

    
    // Gender options
    enum Gender: String, CaseIterable {
        case male = "Male"
        case female = "Female"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("User Data")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)
                .padding(.bottom, 70)
            
            // Full Name TextField
            TextField("Full Name", text: $fullName)
                .textFieldStyle(CustomRoundedTextFieldStyle())
            
            // Email TextField
            TextField("Email", text: $email)
                .textFieldStyle(CustomRoundedTextFieldStyle())
                .keyboardType(.emailAddress)
            
            // Phone TextField
            TextField("Phone", text: $phone)
                .textFieldStyle(CustomRoundedTextFieldStyle())
                .keyboardType(.phonePad)
            
            // Gender Radio Buttons
            Text("Gender")
                .font(.headline)
            HStack {
                ForEach(Gender.allCases, id: \.self) { option in
                    RadioButtonField(text: option.rawValue, isSelected: option == gender) {
                        gender = option
                    }
                }
            }
            
            // Photo Selection
            Text("Photo")
                .font(.headline)
            Button(action: {
                showImagePicker.toggle()
            }) {
                HStack(alignment: .center) {
                    Image(systemName: "photo.badge.plus")
                        .resizable()
                        .frame(width: 50, height: 40)
                    Text("Select Photo")
                        .foregroundColor(.blue)
                        .padding(.bottom, 5)
                }
            }
            
            Spacer() // Center the following elements
            
            // Submit Button
            HStack {
                Spacer()
                NavigationLink(destination: RegisterView()) {
                    Text("Submit")
                        .padding(.horizontal, 100)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                Spacer()
            }
            
            Spacer()
        }
        .padding()
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $selectedImage, isPresented: $showImagePicker)
        }

    }
}

struct RadioButtonField: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                Text(text)
            }
            .foregroundColor(.primary)
            .padding(.vertical, 8)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct UserDataView_Previews: PreviewProvider {
    static var previews: some View {
        UserDataView()
    }
}
