import Foundation

struct ServiceFactory {

    // MARK: - Initialization

    init() {}

    // MARK: - Public API

    func makeArtistListService() -> ArtistListServiceType {
        let session = URLSession.shared
        let client = NetworkClient(networkSession: session)
        return ArtistListService(networkClient: client)
    }
}
