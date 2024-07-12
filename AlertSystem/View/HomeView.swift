import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = NotificationViewModel()
    
    @State private var titleVal = "SOS"
    @State private var bodyVal = "SOS - Somebody needs help!"
    @State private var identifierVal = "SOS"
    @State private var tapProgress: CGFloat = 0.00
    @State private var haveEmergencyContact = true

    var body: some View {
        VStack {
            
            HStack {
                Spacer()
                NavigationLink(destination: {
                    ProfileView()
                }, label: {
                    Image(systemName: "person.crop.circle")
                        .foregroundColor(.blue)
                        .font(.system(size: 30))
                        .padding(.trailing, 10)
                })
                Button(action: {
                    FirebaseViewModel().logout()
                }, label: {
                    Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                        .foregroundColor(.red)
                        .font(.system(size: 30))
                        .padding(.trailing, 10)
                })
            }
            
            ZStack {
                Rectangle()
                    .frame(width: 350, height: 80)
                    .cornerRadius(10)
                    .foregroundColor(Color.gray.opacity(0.1))
                    .padding(.top, 20)
                
                VStack(spacing: 2) {
                    ForEach([("location.fill", "Location", "Jl. Pantura Raya", Color.blue), ("wifi", "Connection", "Active", Color.green)], id: \.1) { icon, text, detail, color in
                        HStack {
                            Image(systemName: icon)
                                .foregroundColor(color)
                                .frame(width: 20)
                                .padding(.trailing, 10)
                            Text(text)
                                .fontWeight(.bold)
                            Spacer()
                            Text(detail)
                        }
                        .padding(.horizontal, 20)
                        
                        if icon != "wifi" {
                            Line(startPoint: CGPoint(x: 10, y: 0), endPoint: CGPoint(x: 350, y: 0))
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                .frame(height: 1)
                                .padding(.vertical, 8)
                        }
                    }
                }
                .padding(.top, 20)
            }
            
            if(haveEmergencyContact && tapProgress >= 1.00){
                ZStack {
                    Rectangle()
                        .frame(width: 350, height: 80)
                        .cornerRadius(10)
                        .foregroundColor(Color.green.opacity(0.2))
                        .padding(.top, 20)
                    
                    HStack(alignment: .center) {
                        Image(systemName: "info.circle.fill")
                            .font(.title)
                            .foregroundColor(.green)
                            .padding(.trailing, 10)
                            .padding(.top, 15)
                        Text("Your SOS alert has been sent successfully.")
                            .frame(width: 250)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 20)
                    }
                }
            }else {
                ZStack {
                    Rectangle()
                        .frame(width: 350, height: 80)
                        .cornerRadius(10)
                        .foregroundColor(Color.yellow.opacity(0.2))
                        .padding(.top, 20)
                    
                    HStack(alignment: .center) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.title)
                            .foregroundColor(.yellow)
                            .padding(.trailing, 10)
                            .padding(.top, 15)
                        Text("To activate alerts, please set up an emergency contact. Go to your profile to add one now.")
                            .frame(width: 250)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 20)
                    }
                }
            }
            
            Spacer()
            
            ZStack {
                Circle()
                    .frame(width: 210, height: 250)
                    .foregroundColor(Color.white)
                    .shadow(radius: 10)
                
                Circle()
                    .trim(from: 0.00, to: tapProgress)
                    .stroke(haveEmergencyContact ? Color.red.opacity(0.7) : Color.gray.opacity(0.7), style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                    .frame(width: 190, height: 190)
                    .rotationEffect(Angle(degrees: -90))
                
                Button(action: {
                    handlePressStart()
                }, label: {
                    Text("SOS")
                        .font(Font.system(size: 60, weight: .bold))
                        .foregroundColor(.white)
                        .padding(50)
                        .background(haveEmergencyContact ? Color.red : Color.gray)
                        .clipShape(Circle())
                })
                .disabled(!haveEmergencyContact)
            }
            
            Button(action: {
                tapProgress = 0.0
            }) {
                HStack {
                    Image(systemName: "x.circle.fill")
                        .foregroundStyle(.white)
                    
                    Text("Cancel")
                        .foregroundStyle(.white)
                }
                .frame(width: 100, height: 10)
                .padding()
                .background(Color.gray)
                .cornerRadius(20)
            }
            .opacity(haveEmergencyContact && tapProgress > 0.0 ? 1 : 0)

            Spacer()
            
            Text("To start emergency tap the button 3 times")
                .frame(width: 200)
                .multilineTextAlignment(.center)
        }
        .padding()
        .onAppear {
            viewModel.requestAuthorization()
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func handlePressStart() {
        tapProgress += 0.35
        if tapProgress >= 1.00 {
            viewModel.scheduleNotification(title: titleVal, body: bodyVal, identifier: identifierVal)
        }
    }

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
