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

        let fetchedList: AnyPublisher<[Artist], Error>
        if cache.isEmpty {
            fetchedList = artistListService
                .getArtistList()
                .handleEvents(receiveOutput: { [weak self] in
                    self?.cache = $0
                })
                .eraseToAnyPublisher()
        } else {
            fetchedList = Just(cache)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }

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
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func getFavoritesList() -> AnyPublisher<[Artist], Error> {
        getArtistList()
            .map({ $0.filter { $0.isFavorite } })
            .eraseToAnyPublisher()
    }

    // MARK: - Private

    private var cache: [Artist] = []
    private let mutex: NSLock = .init()
    private let artistListService: ArtistListServiceType
    private let persistenceClient: PersistenceClientType
}
