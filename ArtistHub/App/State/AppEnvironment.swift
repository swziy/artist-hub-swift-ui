import ArtistHubCore

struct AppEnvironment {
    let artistListRepository: ArtistListRepositoryType
}

extension AppEnvironment {

    static let `default`: Self = .init(
        artistListRepository: ArtistListRepositoryFactory().makeArtistListRepository()
    )
}
