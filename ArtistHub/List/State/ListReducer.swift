import ArtistHubCore
import ComposableArchitecture
import SwiftUI

let listReducer = Reducer<ListState, ListAction, ListEnvironment>.combine(
    entryReducer.forEach(
        state: \.artists,
        action: /ListAction.item(id:action:),
        environment: { _ in EntryEnvironment.default }
    ),
    Reducer { state, action, environment in
        switch action {
        case .select(let tab):
            state.currentTab = tab
            switch tab {
            case .all:
                return environment
                    .artistListRepository
                    .getArtistList()
                    .receive(on: environment.scheduler.animation(.easeInOut))
                    .catchToEffect(ListAction.all)
            case .favorite:
                return environment
                    .artistListRepository
                    .getFavoritesList()
                    .receive(on: environment.scheduler.animation(.easeInOut))
                    .catchToEffect(ListAction.favorites)
            }
        case let .all(.success(artists)):
            state.artists = IdentifiedArrayOf(uniqueElements: artists)
            return .none
        case let .favorites(.success(artists)):
            state.artists = IdentifiedArrayOf(uniqueElements: artists)
            return .none
        case .item(let id, _):
            guard let artist = state.artists.first(where: { $0.id == id }) else {
                return .none
            }

            let savePublisher = environment
                .artistListRepository
                .save(artist: artist)

            if state.currentTab == .favorite {
                return savePublisher.catchToEffect { _ in
                    ListAction.select(.favorite)
                }
            }

            return savePublisher.fireAndForget()
        default:
            return .none
        }
    }
)

