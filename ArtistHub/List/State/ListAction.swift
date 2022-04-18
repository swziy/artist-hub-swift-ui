import ArtistHubCore

enum Tab {
    case all
    case favorite
}

enum ListAction {
    case select(Tab)
    case item(id: Artist.ID, action: EntryAction)
    case all(Result<[Artist], Error>)
    case favorites(Result<[Artist], Error>)
}
