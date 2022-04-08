import Foundation
import Combine

public protocol NetworkSessionType {
    func dataTaskPublisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError>
}

extension URLSession: NetworkSessionType {

    public func dataTaskPublisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        let publisher: URLSession.DataTaskPublisher = dataTaskPublisher(for: request)
        return publisher.eraseToAnyPublisher()
    }
}
