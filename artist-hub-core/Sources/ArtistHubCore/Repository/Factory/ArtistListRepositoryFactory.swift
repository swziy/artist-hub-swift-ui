public struct ArtistListRepositoryFactory {

    // MARK: - Initialization

    public init() {}

    public func makeArtistListRepository() -> ArtistListRepositoryType {
        let artistListService = ServiceFactory().makeArtistListService()
        let persistenceClient = PersistenceClientFactory().makePersistenceClient()

        return ArtistListRepository(artistListService: artistListService, persistenceClient: persistenceClient)
    }
}
