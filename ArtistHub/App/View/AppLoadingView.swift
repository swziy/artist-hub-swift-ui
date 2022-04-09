import SwiftUI
import ArtistHubUI
import ArtistHubCore

struct AppLoadingView: View {

    var body: some View {
        NavigationView {
            HStack {
                Spacer()
                VStack {
                    Spacer().frame(height: 48.0)
                    ProgressView()
                        .progressViewStyle(
                            CircularProgressViewStyle(tint: Color.Fill.accent)
                        )
                    Spacer()
                }
                Spacer()
            }
            .navigationBarTitle("Artist Hub")
            .background(Color.Fill.lightGray)
        }
    }
}

struct AppLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        AppLoadingView()
    }
}
