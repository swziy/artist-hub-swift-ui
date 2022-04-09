import ComposableArchitecture
import SwiftUI
import ArtistHubCore

struct AppView: View {
    let store: Store<AppState, AppAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
                switch viewStore.state.stage {
                case .loading:
                    AppLoadingView()
                        .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.25)))
                case .error:
                    AppErrorView(store: store)
                        .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.25)))
                case .success:
                    ArtistListView(store: store)
                        .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.25)))
                }
            }
            .onAppear(perform: {
                viewStore.send(.reload)
            })

        }
    }
}
