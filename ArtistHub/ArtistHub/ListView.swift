import ComposableArchitecture
import SwiftUI

struct ListView: View {
    let store: Store<AppState, AppAction>

    var body: some View {
        NavigationView {
            List {
                Text("Hello")
            }
            .navigationBarTitle("Artist Hub")
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(
            store: Store(
                initialState: AppState(),
                reducer: appReducer,
                environment: AppEnvironment()
            )
        )
    }
}
