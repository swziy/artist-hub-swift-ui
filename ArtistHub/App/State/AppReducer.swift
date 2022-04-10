import ComposableArchitecture

let appReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
    switch action {
    case .reload:
        state = .loading
        return environment
            .artistListService
            .getArtistList()
            .catchToEffect(AppAction.artistListResponse)
    case .artistListResponse(.failure):
        state = .error
        return .none
    case let .artistListResponse(.success(artists)):
        state = .success(artists)
        return .none
    }
}.debug()
