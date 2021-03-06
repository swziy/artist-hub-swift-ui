import ComposableArchitecture
import SwiftUI
import ArtistHubCore

struct ArtistListView: View {
    let store: Store<ListState, ListAction>

    var body: some View {
        ScrollView {
            LazyVStack { // workaround to get decent transition animation (cannot get the same effect with List ¯\_(ツ)_/¯).
                WithViewStore(store.scope(state: \.currentTab)) { viewStore in
                    Picker(
                        "",
                        selection: viewStore
                            .binding(send: ListAction.select)
                    ) {
                        Text("All").tag(Tab.all)
                        Text("Favorite").tag(Tab.favorite)
                    }
                    .pickerStyle(.segmented)
                    .padding(12.0)
                    .background(Color.Fill.lightGray)
                }
                WithViewStore(store.scope(state: \.artists)) { viewStore in
                    if viewStore.state.isEmpty {
                        AppEmptyView().padding()
                    } else {
                        ForEachStore(
                            store.scope(state: \.artists, action: ListAction.item(id:action:))
                        ) { entryStore in
                            ArtistEntryView(store: entryStore)
                                .transition(.opacity)
                                .padding(
                                    .init(
                                        top: 5,
                                        leading: 12.0,
                                        bottom: 5,
                                        trailing: 12.0
                                    )
                                )
                        }
                    }
                }
            }
        }
    }
}

struct ArtistListView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistListView(
            store: Store(
                initialState: mockListState,
                reducer: listReducer,
                environment: ListEnvironment.default
            )
        )
        .background(Color.Fill.lightGray)
    }
}

let mockListState = ListState(data: [
    .init(
        id: 0,
        avatar: "",
        name: "Vincent van Gogh",
        username: "@gogh",
        date: "2w",
        description: "Dutch post-impressionist painter who is among the most famous and influential figures in the history",
        followers: "22.1M Followers",
        isFavorite: false
    ),
    .init(
        id: 1,
        avatar: "",
        name: "Vincent van Gogh",
        username: "@gogh",
        date: "2w",
        description: "Dutch post-impressionist painter who is among the most famous and influential figures in the history",
        followers: "22.1M Followers",
        isFavorite: false
    ),
    .init(
        id: 2,
        avatar: "",
        name: "Vincent van Gogh",
        username: "@gogh",
        date: "2w",
        description: "Dutch post-impressionist painter who is among the most famous and influential figures in the history",
        followers: "22.1M Followers",
        isFavorite: false
    )
])
