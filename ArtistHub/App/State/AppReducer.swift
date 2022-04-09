import ComposableArchitecture

let appReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
    switch action {
    case .reload:
        state.stage = .loading
        return environment
            .artistListService
            .getArtistList()
            .catchToEffect(AppAction.artistListResponse)
    case .artistListResponse(.failure):
        state.artists = []
        state.stage = .error
        return .none
    case let .artistListResponse(.success(artists)):
        state.artists = artists
        state.stage = .success
        return .none
    }
}
