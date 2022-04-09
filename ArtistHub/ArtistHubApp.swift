import ComposableArchitecture
import SwiftUI
import ArtistHubCore
import Combine

struct AppState: Equatable {
    var artists: [Artist] = []

}

enum AppAction {
    case appLoaded
    case artistListResponse(Result<[Artist], Error>)
}

struct AppEnvironment {
    let artistListService: ArtistListServiceType
}

let appReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
    switch action {
    case .appLoaded:
        return environment
            .artistListService
            .getArtistList()
            .catchToEffect(AppAction.artistListResponse)
    case .artistListResponse(.failure):
        state.artists = []
        return .none
    case let .artistListResponse(.success(artists)):
        state.artists = artists
        return .none
    }
}

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
            ArtistListView(
                store: Store(
                    initialState: AppState(artists: []),
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
