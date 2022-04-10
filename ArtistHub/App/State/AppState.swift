import ArtistHubCore

enum AppState: Equatable {
    case loading
    case success([Artist])
    case error
}
