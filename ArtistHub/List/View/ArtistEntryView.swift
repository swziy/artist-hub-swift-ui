import SwiftUI
import ArtistHubUI
import ArtistHubCore

struct ArtistEntryView: View {
    let artist: Artist

    var body: some View {
        VStack(alignment: .leading, spacing: 12.0) {
            HStack {
                Image.Icons.placeholder
                    .resizable()
                    .frame(width: 36.0, height: 36.0)
                    .clipShape(Circle())
                Spacer(minLength: 8.0)
                VStack(alignment: .leading) {
                    Text(artist.name)
                        .font(Font.system(size: 16.0, weight: .bold))
                        .resizableOneLine()
                        .foregroundColor(.black)
                    HStack {
                        Text(artist.username)
                            .foregroundColor(Color.Fill.gray)
                            .font(Font.system(size: 12.0, weight: .light).italic())
                        Spacer()
                        Text(artist.date)
                            .foregroundColor(Color.Fill.gray)
                            .font(Font.system(size: 12.0, weight: .light).italic())
                    }
                }
            }
            Text(artist.description)
                .foregroundColor(.black)
                .font(.system(size: 14, weight: .regular))
            HStack {
                Text(artist.followers)
                    .foregroundColor(Color.Fill.gray)
                    .font(Font.system(size: 12.0, weight: .light).italic())
                Spacer()
                Button(action: { }) {
                    Image.Icons.heartFilled
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

struct ArtistEntryView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistEntryView(
            artist: .init(
                id: 0,
                avatar: "",
                name: "Vincent van Gogh",
                username: "@gogh",
                date: "2w",
                description: "Dutch post-impressionist painter who is among the most famous and influential figures in the history",
                followers: "22.1M Followers",
                isFavorite: false
            )
        )
            .padding(12.0)
    }
}
