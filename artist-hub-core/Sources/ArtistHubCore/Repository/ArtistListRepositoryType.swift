import Combine

public protocol ArtistListRepositoryType {
    func getArtistList() -> AnyPublisher<[Artist], Error>
    func getFavoritesList() -> AnyPublisher<[Artist], Error>
}
