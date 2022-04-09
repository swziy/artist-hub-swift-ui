import SwiftUI
import ArtistHubUI
import ArtistHubCore
import ComposableArchitecture

struct AppErrorView: View {
    let store: Store<AppState, AppAction>

    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 16.0) {
                Spacer()
                WithViewStore(store) { viewStore in
                    Image(uiImage: UIImage.Icons.error)
                    Text("Something went wrong...")
                        .foregroundColor(Color.Fill.gray)
                        .font(Font.system(size: 14.0, weight: .regular))
                    Button("Retry") {
                        viewStore.send(.reload)
                    }
                    .buttonStyle(RetryButtonStyle())
                }
                Spacer()
            }
            Spacer()
        }
    }
}

private struct RetryButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? Color.Fill.gray : .black)
            .frame(width: 96.0, height: 40)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2))
    }
}

struct AppErrorView_Previews: PreviewProvider {
    static var previews: some View {
        AppErrorView(store: Store(
            initialState: mockAppState,
            reducer: appReducer,
            environment: AppEnvironment(
                artistListService: ServiceFactory().makeArtistListService()
            )
        ))
    }
}
