import ArtistHubCore

enum ListAction: Equatable {
    case item(id: Artist.ID, action: EntryAction)
}
