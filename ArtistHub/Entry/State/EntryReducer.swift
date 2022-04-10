import ArtistHubCore
import ComposableArchitecture

let entryReducer = Reducer<Artist, EntryAction, EntryEnvironment> { state, action, environment in
    switch action {
    case .favoriteTapped:
        state.isFavorite.toggle()
        return .none
    }
}
