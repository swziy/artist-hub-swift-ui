import ComposableArchitecture
import SwiftUI
import ArtistHubCore

struct ArtistListView: View {
    let store: Store<AppState, AppAction>

    var body: some View {
        NavigationView {
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
                .onAppear(perform: {
                    viewStore.send(.appLoaded)
                })
            }
            .navigationBarTitle("Artist Hub")
            .background(Color.Fill.lightGray)
        }
    }
}

struct ArtistListView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistListView(
            store: Store(
                initialState: mockAppState,
                reducer: appReducer,
                environment: AppEnvironment(
                    artistListService: ServiceFactory().makeArtistListService()
                )
            )
        )
    }
}

let mockAppState = AppState(artists: [
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
