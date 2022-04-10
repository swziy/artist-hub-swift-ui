import ArtistHubCore
import Combine
import ComposableArchitecture
import SwiftUI

@main
struct AppLauncher {

    static func main() throws {
        if NSClassFromString("XCTestCase") == nil {
            ArtistHubApp.main()
        } else {
            TestApp.main()
        }
    }
}

struct ArtistHubApp: App {

    init() {
        NavigationBarAppearanceConfigurator().configure()
    }

    var body: some Scene {
        WindowGroup {
            AppView(
                store: Store(
                    initialState: AppState.loading,
                    reducer: appReducer,
                    environment: AppEnvironment(
                        artistListService: ServiceFactory().makeArtistListService()
                    )
                )
            )
        }
    }
}

struct TestApp: App {

    var body: some Scene {
        WindowGroup { Text("Running Unit Tests") }
    }
}
