//
//  HomeView.swift
//  AlertSystem
//
//  Created by Joshua Wenata Sunarto on 11/07/24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = NotificationViewModel() // Use @StateObject for managing ObservableObject
    
    @State private var titleVal = "SOS"
    @State private var bodyVal = "SOS - Somebody needs help!"
    @State private var identifierVal = "SOS"

    var body: some View {
        VStack {
            Button(action: {
                viewModel.scheduleNotification(title: titleVal, body: bodyVal, identifier: identifierVal)
            }, label: {
                Text("Schedule Notification")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            })
        }
        .padding()
        .onAppear {
            viewModel.requestAuthorization()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
