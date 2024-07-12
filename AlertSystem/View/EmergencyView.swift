import SwiftUI

struct EmergencyContact: Identifiable {
    var id = UUID()
    var name: String = ""
    var email: String = ""
}

struct EmergencyView: View {
    @State private var contacts: [EmergencyContact] = [EmergencyContact(), EmergencyContact()]
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    ForEach(contacts.indices, id: \.self) { index in
                        Section(header: Text("Person \(index + 1)")) {
                            TextField("Name", text: $contacts[index].name)
                            TextField("Email", text: $contacts[index].email)
                        }
                    }
                    Button(action: {
                        contacts.append(EmergencyContact())
                    }) {
                        HStack {
                            Image(systemName: "plus.circle")
                            Text("Add emergency contact")
                        }
                    }
                }
                .navigationBarTitle("Emergency Contact")
                
                Button(action: {
                    // Handle save action
                }) {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
        }
    }
}
