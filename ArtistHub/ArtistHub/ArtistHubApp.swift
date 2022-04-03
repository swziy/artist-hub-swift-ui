import ComposableArchitecture
import SwiftUI

struct AppState {

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
    }

    var body: some Scene {
        WindowGroup {
            ListView(
                store: Store(
                    initialState: AppState(),
                    reducer: appReducer,
                    environment: AppEnvironment()
                )
            )
        }
    }
}
