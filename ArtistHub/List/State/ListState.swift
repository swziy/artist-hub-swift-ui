import ArtistHubCore
import ComposableArchitecture

struct ListState: Equatable, Hashable {

    var artists: IdentifiedArrayOf<Artist> {
        get {
            currentTab == .favorite ? data.filter { $0.isFavorite } : data
        }
        set {
            data = newValue
        }
    }

    var currentTab: Tab = .all

    // MARK: - Initialization

    init(data: IdentifiedArrayOf<Artist>) {
        self.data = data
    }

    // MARK: - Private

    private var data: IdentifiedArrayOf<Artist>
}
