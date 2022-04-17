import CoreData
import Combine

public protocol PersistenceClientType {
    func observe<T: DomainConvertibleType>(request: NSFetchRequest<T>) -> AnyPublisher<[T.Domain], PersistenceError>
    func fetch<T: DomainConvertibleType>(request: NSFetchRequest<T>) -> AnyPublisher<[T.Domain], PersistenceError>
    func saveOrUpdate<T: EntityConvertibleType>(object: T) -> AnyPublisher<Void, PersistenceError>
}
