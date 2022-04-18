import ArtistHubCore
import ComposableArchitecture

struct ListEnvironment {
    let artistListRepository: ArtistListRepositoryType
    let scheduler: AnySchedulerOf<DispatchQueue>
}

extension ListEnvironment {

    static let `default`: Self = .init(
        artistListRepository: AppEnvironment.default.artistListRepository,
        scheduler: .main
    )
}
