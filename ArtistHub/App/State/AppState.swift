import ArtistHubCore

enum AppStage: Equatable {
    case loading
    case success([Artist])
    case error
}

struct AppState: Equatable {
    var stage: AppStage = .loading
}
