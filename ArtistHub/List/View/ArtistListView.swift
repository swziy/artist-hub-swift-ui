import ComposableArchitecture
import SwiftUI
import ArtistHubCore

struct ArtistListView: View {
    let store: Store<ListState, ListAction>

    var body: some View {
        List {
            WithViewStore(store.scope(state: \.currentTab)) { viewStore in
                Picker("", selection: viewStore.binding(send: ListAction.select)) {
                    Text("All").tag(Tab.all)
                    Text("Favorite").tag(Tab.favorite)
                }
                .pickerStyle(.segmented)
                .padding(12.0)
                .background(Color.Fill.lightGray)
                .listRowInsets(
                    .init(
                        top: 0.0,
                        leading: 0.0,
                        bottom: 0.0,
                        trailing: 0.0
                    )
                )
            }
            ForEachStore(
                store.scope(state: \.artists, action: ListAction.item(id:action:))
            ) { entryStore in
                ArtistEntryView(store: entryStore)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.Fill.lightGray)
                    .listRowInsets(
                        .init(
                            top: 10.0,
                            leading: 12.0,
                            bottom: 10.0,
                            trailing: 12.0
                        ))
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct ArtistListView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistListView(
            store: Store(
                initialState: mockListState,
                reducer: listReducer,
                environment: ListEnvironment()
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
