import ComposableArchitecture
import SwiftUI

struct ListView: View {
    let store: Store<AppState, AppAction>

    var body: some View {
        NavigationView {
            WithViewStore(store) { viewStore in
                List {
                    ForEach(viewStore.artists) { artist in
                        Text(artist.name)
                    }
                }
            }
            .navigationBarTitle("Artist Hub")
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(
            store: Store(
                initialState: AppState(artists: [
                    .init(
                        id: 0,
                        avatar: "",
                        name: "name-1",
                        username: "username-1",
                        date: "date-1",
                        description: "description-1",
                        followers: "followers-1",
                        isFavorite: false),
                    .init(
                        id: 1,
                        avatar: "",
                        name: "name-2",
                        username: "username-2",
                        date: "date-2",
                        description: "description-2",
                        followers: "followers-2",
                        isFavorite: true),
                    .init(
                        id: 2,
                        avatar: "",
                        name: "name-3",
                        username: "username-3",
                        date: "date-3",
                        description: "description-3",
                        followers: "followers-3",
                        isFavorite: false)
                ]),
                reducer: appReducer,
                environment: AppEnvironment()
            )
        )
    }
}
