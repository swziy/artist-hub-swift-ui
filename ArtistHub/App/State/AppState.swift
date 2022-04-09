import ArtistHubCore

enum AppStage: Equatable {
    case loading
    case success
    case error
}

struct AppState: Equatable {
    var stage: AppStage = .loading
    var artists: [Artist] = []
}
