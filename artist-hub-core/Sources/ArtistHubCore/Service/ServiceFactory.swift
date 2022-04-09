import Foundation

public struct ServiceFactory {

    // MARK: - Initialization

    public init() {}

    // MARK: - Public API

    public func makeArtistListService() -> ArtistListServiceType {
        let session = URLSession.shared
        let client = NetworkClient(networkSession: session)
        return ArtistListService(networkClient: client)
    }
}
