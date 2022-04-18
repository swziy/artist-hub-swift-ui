import Combine

public protocol ArtistListRepositoryType {
    func getArtistList() -> AnyPublisher<[Artist], Error>
    func getFavoritesList() -> AnyPublisher<[Artist], Error>
    func save(artist: Artist) -> AnyPublisher<Void, Error>
}
