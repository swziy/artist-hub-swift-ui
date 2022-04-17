import Combine

protocol ArtistListServiceType {
    func getArtistList() -> AnyPublisher<[Artist], Error>
}
