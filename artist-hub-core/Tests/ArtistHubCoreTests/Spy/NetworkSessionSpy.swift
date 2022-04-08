import ArtistHubCore
import Combine
import Foundation

final class NetworkSessionSpy: NetworkSessionType {

    var stubbedResult: ((Result<(data: Data, response: URLResponse), URLError>) -> Void)?

    // MARK: - NetworkSessionType

    func dataTaskPublisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        let publisher = Future<(data: Data, response: URLResponse), URLError> { callback in
            self.stubbedResult = callback
        }
        return publisher.eraseToAnyPublisher()
    }
}
