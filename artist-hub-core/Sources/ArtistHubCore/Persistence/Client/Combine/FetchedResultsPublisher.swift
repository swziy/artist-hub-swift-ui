import Combine
import CoreData

final class FetchedResultsPublisher<ResultType>: Publisher where ResultType: NSFetchRequestResult {

    // MARK: - Initialization

    init(request: NSFetchRequest<ResultType>, context: NSManagedObjectContext) {
        self.request = request
        self.context = context
    }

    // MARK: - Publisher

    typealias Output = [ResultType]
    typealias Failure = NSError

    func receive<S>(subscriber: S) where S: Subscriber, S.Failure == Failure, S.Input == Output {
        subscriber.receive(
            subscription: FetchedResultsSubscription(
                subscriber: subscriber,
                request: request,
                context: context
            )
        )
    }

    // MARK: - Private

    private let request: NSFetchRequest<ResultType>
    private let context: NSManagedObjectContext
}


