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
            Text("Personal Information")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)
                .padding(.bottom, 70)
            
            // Full Name TextField
            Text("Full Name")
                .font(.headline)
            
            TextField("Full Name", text: $fullName)
                .textFieldStyle(CustomRoundedTextFieldStyle())
            
            // Email TextField
            Text("Email")
                .font(.headline)
            
            TextField("Email", text: $email)
                .textFieldStyle(CustomRoundedTextFieldStyle())
                .keyboardType(.emailAddress)
            
            // Phone TextField
            Text("Phone")
                .font(.headline)
            
            TextField("Phone", text: $phone)
                .textFieldStyle(CustomRoundedTextFieldStyle())
                .keyboardType(.phonePad)
            
            Text("Gender")
                .font(.headline)
            
            HStack {
                ForEach(Gender.allCases, id: \.self) { option in
                    RadioButtonField(text: option.rawValue, isSelected: option == gender) {
                        gender = option
                    }
                    .background(option == gender ? Color.blue.opacity(0.2) : Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(option == gender ? Color.blue : Color.gray, lineWidth: 1)
                    )
                }
            }
            .padding()
            
            // Photo Selection
//            Text("Photo")
//                .font(.headline)
//            Button(action: {
//                showImagePicker.toggle()
//            }) {
//                HStack(alignment: .center) {
//                    Image(systemName: "photo.badge.plus")
//                        .resizable()
//                        .frame(width: 50, height: 40)
//                    Text("Select Photo")
//                        .foregroundColor(.blue)
//                        .padding(.bottom, 5)
//                }
//            }
            
            Spacer() // Center the following elements
            
            // Submit Button
            HStack {
                Spacer()
                NavigationLink(destination: RegisterView()) {
                    Text("Submit")
                        .padding(.horizontal, 120)
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
                Text(text)
                    .foregroundColor(isSelected ? .blue : .black)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.blue)
                } else {
                    Image(systemName: "circle")
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .background(isSelected ? Color.blue.opacity(0.2) : Color.gray.opacity(0.1))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isSelected ? Color.blue : Color.gray, lineWidth: 1)
            )
        }
    }
}

