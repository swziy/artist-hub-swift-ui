import ArtistHubCore
import ComposableArchitecture

let listReducer: Reducer<ListState, ListAction, ListEnvironment> = entryReducer
    .forEach(
        state: \.artists,
        action: /ListAction.item(id:action:),
        environment: { _ in EntryEnvironment() }
    )
    .debug()
