import Combine
import CombineSchedulers
import Foundation

public final class NetworkClient {

    // MARK: - Initialization

    public init(
        networkSession: NetworkSessionType,
        scheduler: AnySchedulerOf<DispatchQueue> = .main
    ) {
        self.networkSession = networkSession
        self.scheduler = scheduler
    }

    // MARK: - Public API

    public func request(for url: String) -> AnyPublisher<Void, Error> {
        let dataPublisher: AnyPublisher<Data, Error> = request(for: url)
        return dataPublisher
            .map { _ in Void() }
            .eraseToAnyPublisher()
    }

    public func request<R>(for url: String) -> AnyPublisher<R, Error> where R: Decodable {
        request(for: url)
            .decode(type: R.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    // MARK: - Private

    private let networkSession: NetworkSessionType
    private let scheduler: AnySchedulerOf<DispatchQueue>

    private func request(for url: String) -> AnyPublisher<Data, Error> {
        guard let url = URL(string: url) else {
            return Fail<Data, Error>(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }

        return networkSession
            .dataTaskPublisher(for: URLRequest(url: url))
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                          throw URLError(.badServerResponse)
                      }
                return element.data
            }
            .receive(on: scheduler)
            .eraseToAnyPublisher()
    }
}
