import SwiftUI
import Firebase

struct RegisterView: View {
    var body: some View {
        VStack {
            Button(action: {
                // Get the top most view controller
                guard let presentingViewController = UIApplication.shared.windows.first?.rootViewController else {
                    print("Failed to get the presenting view controller")
                    return
                }
                
                signInWithGoogle(presentingViewController: presentingViewController) { result in
                    switch result {
                    case .success(let user):
                        print("User signed in with Firebase: \(user.email ?? "No email")")
                        // Proceed with your app's flow
                    case .failure(let error):
                        print("Error during sign-in: \(error.localizedDescription)")
                    }
                }
            }, label: {
                Text("Sign in with Google")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            })
        }
    }
}
