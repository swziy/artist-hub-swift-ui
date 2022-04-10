import ArtistHubCore
import ComposableArchitecture

struct ListState: Equatable {
    var artists: IdentifiedArrayOf<Artist>
}
