import Combine

public protocol ArtistListRepositoryType {
    func getArtistList() -> AnyPublisher<[Artist], Error>
}
