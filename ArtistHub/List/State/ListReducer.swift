import ArtistHubCore
import ComposableArchitecture
import SwiftUI

let listReducer = Reducer<ListState, ListAction, ListEnvironment>.combine(
    entryReducer.forEach(
        state: \.artists,
        action: /ListAction.item(id:action:),
        environment: { _ in EntryEnvironment() }
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
        default:
            return .none
        }
    }
)

