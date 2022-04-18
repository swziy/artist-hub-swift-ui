import ArtistHubCore
import ComposableArchitecture

struct ListState: Equatable, Hashable {

    var artists: IdentifiedArrayOf<Artist>
    var currentTab: Tab = .all

    // MARK: - Initialization

    init(data: IdentifiedArrayOf<Artist>) {
        self.artists = data
    }
}
