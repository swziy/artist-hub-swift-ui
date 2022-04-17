import Combine
import CoreData
import Foundation

final class FetchedResultsSubscription<SubscriberType, ResultType>: NSObject, Subscription, NSFetchedResultsControllerDelegate where
    SubscriberType: Subscriber,
    SubscriberType.Input == [ResultType],
    SubscriberType.Failure == NSError,
    ResultType: NSFetchRequestResult
{

    // MARK: - Initialization

    init(subscriber: SubscriberType,
         request: NSFetchRequest<ResultType>,
         context: NSManagedObjectContext) {
        self.subscriber = subscriber
        self.request = request
        self.context = context
    }

    // MARK: - Subscription

    func request(_ demand: Subscribers.Demand) {
        guard demand > 0,
            let subscriber = subscriber,
            let request = request,
            let context = context else { return }

        controller = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        controller?.delegate = self

        do {
            try controller?.performFetch()
            if let fetchedObjects = controller?.fetchedObjects {
                _ = subscriber.receive(fetchedObjects)
            }
        } catch {
            subscriber.receive(completion: .failure(error as NSError))
        }
    }

    // MARK: - Cancellable

    func cancel() {
        subscriber = nil
        controller = nil
        request = nil
        context = nil
    }

    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerDidChangeContent(
        _ controller: NSFetchedResultsController<NSFetchRequestResult>
    ) {
        guard let subscriber = subscriber,
            controller == self.controller else { return }

        if let fetchedObjects = self.controller?.fetchedObjects {
            _ = subscriber.receive(fetchedObjects)
        }
    }

    // MARK: - Private

    private var subscriber: SubscriberType?
    private var request: NSFetchRequest<ResultType>?
    private var context: NSManagedObjectContext?
    private var controller: NSFetchedResultsController<ResultType>?
}
