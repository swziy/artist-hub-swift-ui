import ArtistHubCore

enum Tab {
    case all
    case favorite
}

enum ListAction: Equatable {
    case select(Tab)
    case item(id: Artist.ID, action: EntryAction)
}
