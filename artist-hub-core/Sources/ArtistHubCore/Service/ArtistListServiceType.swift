import Combine

public protocol ArtistListServiceType {
    func getArtistList() -> AnyPublisher<[Artist], Error>
}
