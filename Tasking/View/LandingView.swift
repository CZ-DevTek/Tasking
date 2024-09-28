import SwiftUI

struct LandingView: View {
    var body: some View {
        VStack {
            Spacer()
            Image("AppLogo") // Replace "AppLogo" with your logo image name
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200) // Adjust size as needed
            Spacer()
        }
        .background(Color.white) // Set background color
        .edgesIgnoringSafeArea(.all) // Extend view to cover the whole screen
    }
}

#Preview {
    LandingView()
}