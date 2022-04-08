import ComposableArchitecture
import SwiftUI
import ArtistHubCore
import Combine

struct AppState: Equatable {
    var artists: [Artist] = []

}

enum AppAction {

}

struct AppEnvironment {

}

let appReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
    switch action {

    }
}

@main
struct ArtistHubApp: App {
    let networkClient: NetworkClient = .init(networkSession: URLSession.shared)

    init() {
        NavigationBarAppearanceConfigurator().configure()
    }

    var body: some Scene {
        WindowGroup {
            ArtistListView(
                store: Store(
                    initialState: mockAppState,
                    reducer: appReducer,
                    environment: AppEnvironment()
                )
            )
        }
    }
}
