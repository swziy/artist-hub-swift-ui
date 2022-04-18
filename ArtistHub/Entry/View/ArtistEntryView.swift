import ArtistHubUI
import ArtistHubCore
import ComposableArchitecture
import SwiftUI

struct ArtistEntryView: View {
    let store: Store<Artist, EntryAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            VStack(alignment: .leading, spacing: 12.0) {
                HStack {
                    AsyncImage(
                        url: URL(string: viewStore.state.avatar),
                        transaction: .init(animation: .easeInOut(duration: 0.25))
                    ) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        default:
                            Image.Icons.placeholder.resizable()
                        }
                    }
                    .frame(width: 36.0, height: 36.0)
                    .clipShape(Circle())
                    Spacer(minLength: 8.0)
                    VStack(alignment: .leading) {
                        Text(viewStore.state.name)
                            .font(Font.system(size: 16.0, weight: .bold))
                            .resizableOneLine()
                            .foregroundColor(.black)
                        HStack {
                            Text(viewStore.state.username)
                                .foregroundColor(Color.Fill.gray)
                                .font(Font.system(size: 12.0, weight: .light).italic())
                            Spacer()
                            Text(viewStore.state.date)
                                .foregroundColor(Color.Fill.gray)
                                .font(Font.system(size: 12.0, weight: .light).italic())
                        }
                    }
                }
                Text(viewStore.state.description)
                    .foregroundColor(.black)
                    .font(.system(size: 14, weight: .regular))
                HStack {
                    Text(viewStore.state.followers)
                        .foregroundColor(Color.Fill.gray)
                        .font(Font.system(size: 12.0, weight: .light).italic())
                    Spacer()
                    Button(action: {
                        viewStore.send(.favoriteTapped)
                    }) {
                        ZStack {
                            if viewStore.state.isFavorite {
                                Image.Icons.heartFilled.transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.15)))
                            } else {
                                Image.Icons.heartOutline.transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.15)))
                            }
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(12.0)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
            )
        }
    }
}

struct ArtistEntryView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistEntryView(
            store: Store(
                initialState: .init(
                    id: 0,
                    avatar: "",
                    name: "Vincent van Gogh",
                    username: "@gogh",
                    date: "2w",
                    description: "Dutch post-impressionist painter who is among the most famous and influential figures in the history",
                    followers: "22.1M Followers",
                    isFavorite: false
                ),
                reducer: entryReducer,
                environment: EntryEnvironment.default)
        )
        .padding(12.0)
    }
}
