import ArtistHubCore
import Combine
import Foundation

final class NetworkSessionSpy: NetworkSessionType {

    final class NetworkSessionPublisher: Publisher {
        typealias Output = (data: Data, response: URLResponse)
        typealias Failure = URLError

        var stubbedResult: AnySubscriber<Output, Failure>?

        func receive<S>(
            subscriber: S
        ) where S : Subscriber, URLError == S.Failure, (data: Data, response: URLResponse) == S.Input {
            subscriber.receive(subscription: AnySubscription { [weak self] in
                self?.stubbedResult = nil
            })
            self.stubbedResult = AnySubscriber(subscriber)
        }
    }

    var publisher: NetworkSessionPublisher?

    // MARK: - NetworkSessionType

    func dataTaskPublisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        let publisher = NetworkSessionPublisher()
        self.publisher = publisher
        return publisher.eraseToAnyPublisher()
    }
}
