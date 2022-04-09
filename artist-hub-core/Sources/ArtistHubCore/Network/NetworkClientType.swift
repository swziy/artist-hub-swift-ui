import Combine

protocol NetworkClientType {
    func request(for url: String) -> AnyPublisher<Void, Error>
    func request<R>(for url: String) -> AnyPublisher<R, Error> where R: Decodable
}
