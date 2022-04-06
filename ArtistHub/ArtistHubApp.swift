import ComposableArchitecture
import SwiftUI
import ArtistHubCore
import ArtistHubUI

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

    init() {
        NavigationBarAppearanceConfigurator().configure()
        print(ArtistHubCore().text)
        print(ArtistHubUI().text)
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
