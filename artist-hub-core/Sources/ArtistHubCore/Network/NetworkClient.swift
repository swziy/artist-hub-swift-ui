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

    public func request<R: Decodable>(for url: String) -> AnyPublisher<R, Error> {
        guard let url = URL(string: url) else {
            return Fail<R, Error>(error: URLError(.badURL))
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
            .decode(type: R.self, decoder: JSONDecoder())
            .receive(on: scheduler)
            .eraseToAnyPublisher()
    }

    // MARK: - Private

    private let networkSession: NetworkSessionType
    private let scheduler: AnySchedulerOf<DispatchQueue>
}
