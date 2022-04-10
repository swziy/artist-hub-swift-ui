import ComposableArchitecture
import SwiftUI
import ArtistHubCore

struct ArtistListView: View {
    let store: Store<ListState, ListAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            List {
                ForEach(viewStore.artists) { artist in
                    ArtistEntryView(artist: artist)
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

let mockListState = ListState(artists: [
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
