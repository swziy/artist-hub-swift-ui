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
        state.stage = .error
        return .none
    case let .artistListResponse(.success(artists)):
        state.stage = .success(artists)
        return .none
    }
}
