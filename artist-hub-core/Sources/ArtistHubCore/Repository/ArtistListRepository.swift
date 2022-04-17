import Combine
import Foundation

final class ArtistListRepository: ArtistListRepositoryType {

    // MARK: - Initialization

    init(artistListService: ArtistListServiceType, persistenceClient: PersistenceClientType) {
        self.artistListService = artistListService
        self.persistenceClient = persistenceClient
    }

    func getArtistList() -> AnyPublisher<[Artist], Error> {
        let storedList = persistenceClient
            .fetch(request: Artist.allStoredFetchRequest())
            .mapError { $0 as Error }
            .eraseToAnyPublisher()

        let fetchedList = artistListService
            .getArtistList()

        return fetchedList
            .combineLatest(storedList)
            .map({ (fetched, stored) in
                return fetched.map { artist in
                    if let storedValue = stored.first(where: { $0.id == artist.id })?.isFavorite {
                        return artist.copy(isFavorite: storedValue)
                    }
                    return artist
                }
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    // MARK: - Private

    private var cache: [Artist] = []
    private let artistListService: ArtistListServiceType
    private let persistenceClient: PersistenceClientType
}
