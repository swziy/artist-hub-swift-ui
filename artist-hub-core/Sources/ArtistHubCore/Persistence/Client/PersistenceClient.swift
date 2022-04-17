import CoreData
import Combine

final class PersistenceClient: PersistenceClientType {

    // MARK: - Initialization

    init(containerFactory: PersistentContainerFactoryType) {
        self.containerFactory = containerFactory
    }

    // MARK: - PersistenceClientType

    func observe<T: DomainConvertibleType>(request: NSFetchRequest<T>) -> AnyPublisher<[T.Domain], PersistenceError> {
        observeInternal(request: request)
            .map { $0.domain() }
            .eraseToAnyPublisher()
    }

    func fetch<T: DomainConvertibleType>(request: NSFetchRequest<T>) -> AnyPublisher<[T.Domain], PersistenceError> {
        fetchInternal(request: request)
            .map { $0.domain() }
            .eraseToAnyPublisher()
    }

    func saveOrUpdate<T: EntityConvertibleType>(object: T) -> AnyPublisher<Void, PersistenceError> {
        guard let context = context else {
            return Fail(error: PersistenceError.operationError)
                .eraseToAnyPublisher()
        }

        return fetchInternal(request: object.fetchRequest())
            .tryMap { entities in
                let entity = entities.first ?? T.Entity(context: context)
                object.update(entity)
                try context.save()
                return Void()
            }
            .mapError { _ in
                PersistenceError.operationError
            }
            .eraseToAnyPublisher()
    }

    // MARK: - Private

    private let containerFactory: PersistentContainerFactoryType
    private lazy var context = containerFactory.makePersistentContainer()?.newBackgroundContext()

    private func observeInternal<T>(request: NSFetchRequest<T>) -> AnyPublisher<[T], PersistenceError> {
        guard let context = context else {
            return Fail(error: PersistenceError.operationError)
                .eraseToAnyPublisher()
        }

        return FetchedResultsPublisher(request: request, context: context)
            .mapError { _ in PersistenceError.operationError }
            .eraseToAnyPublisher()
    }

    private func fetchInternal<T>(request: NSFetchRequest<T>) -> AnyPublisher<[T], PersistenceError> {
        guard let context = context else {
            return Fail(error: PersistenceError.operationError)
                .eraseToAnyPublisher()
        }

        return Just(context)
            .tryMap {
                try $0.fetch(request)
            }
            .mapError { _ in
                PersistenceError.operationError
            }
            .eraseToAnyPublisher()
    }
}
