import ArtistHubCore
import ComposableArchitecture

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
            return .none
        case .item:
            return .none
        }
    }
)

