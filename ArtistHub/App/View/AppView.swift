import ComposableArchitecture
import SwiftUI
import ArtistHubCore

struct AppView: View {
    let store: Store<AppState, AppAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                ZStack {
                    switch viewStore.state {
                    case .loading:
                        AppLoadingView()
                            .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.25)))
                    case .error:
                        AppErrorView(store: store)
                            .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.25)))
                    case let .success(artists):
                        ArtistListView(
                            store: Store(
                                initialState: ListState(artists: IdentifiedArrayOf(uniqueElements: artists)),
                                reducer: listReducer,
                                environment: ListEnvironment()
                            )
                        )
                        .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.25)))
                    }
                }
                .navigationTitle("Artist Hub")
                .background(Color.Fill.lightGray)
            }
            .onAppear(perform: {
                viewStore.send(.reload)
            })

        }
    }
}
