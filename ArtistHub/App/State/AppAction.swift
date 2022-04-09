import ArtistHubCore

enum AppAction {
    case reload
    case artistListResponse(Result<[Artist], Error>)
}
