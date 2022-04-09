import Combine

final class ArtistListService: ArtistListServiceType {

    // MARK: - Initialization

    init(networkClient: NetworkClientType) {
        self.networkClient = networkClient
    }

    // MARK: - ArtistListServiceType

    func getArtistList() -> AnyPublisher<[Artist], Error> {
        networkClient.request(for: url)
    }

    // MARK: - Private

    private let networkClient: NetworkClientType
    private let url: String = "https://gist.githubusercontent.com/swziy/fdb13610fc7bd5b33556c0996a20af1f/raw/c9a537f8ec230bb9959143b59330fc369a9fcd56/artist-hub-list.json"
}
