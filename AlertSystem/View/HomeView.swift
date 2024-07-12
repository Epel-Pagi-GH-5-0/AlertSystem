import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = NotificationViewModel()
    
    @State private var titleVal = "SOS"
    @State private var bodyVal = "SOS - Somebody needs help!"
    @State private var identifierVal = "SOS"
    @State private var tapProgress: CGFloat = 0.00

    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .frame(width: 210, height: 350)
                    .foregroundColor(Color.white)
                    .shadow(radius: 10)
                
                Circle()
                    .trim(from: 0.00, to: tapProgress)
                    .stroke(Color.red.opacity(0.7), style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                    .frame(width: 190, height: 190)
                    .rotationEffect(Angle(degrees: -90))
                
                Button(action: {
                    handlePressStart()
                }, label: {
                    Text("SOS")
                        .font(Font.system(size: 60, weight: .bold))
                        .foregroundColor(.white)
                        .padding(50)
                        .background(Color.red)
                        .clipShape(Circle())
                })
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
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
