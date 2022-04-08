import Combine

final class AnySubscription: Subscription {
    let cancelTask: () -> Void

    init(cancelTask: @escaping () -> Void) {
        self.cancelTask = cancelTask
    }

    // MARK: - Subscription

    func request(_ demand: Subscribers.Demand) {}

    func cancel() {
        cancelTask()
    }
}
