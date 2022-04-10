import ArtistHubCore
import ComposableArchitecture

let listReducer = Reducer<ListState, ListAction, ListEnvironment>.combine(
    entryReducer.forEach(
        state: \.artists,
        action: /ListAction.item(id:action:),
        environment: { _ in EntryEnvironment() }
    ),
    Reducer { state, action, environment in
        return .none
    }
).debug()
