import XCTest
import Combine
import CombineSchedulers
@testable import ArtistHubCore

class NetworkClientTests: XCTestCase {

    var cancellables: Set<AnyCancellable>!
    var testScheduler: TestSchedulerOf<DispatchQueue>!
    var networkSessionSpy: NetworkSessionSpy!
    var sut: NetworkClient!

    override func setUp() {
        super.setUp()
        cancellables = []
        testScheduler = DispatchQueue.test
        networkSessionSpy = .init()
        sut = .init(networkSession: networkSessionSpy, scheduler: testScheduler.eraseToAnyScheduler())
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        networkSessionSpy = nil
        testScheduler = nil
        cancellables = nil
    }

    func test_whenPublisherReturnsError_shouldBeReported() {
        // Given
        var completion: [Error] = []
        var values = [Artist]()
        sut.request(for: "https://google.com")
            .sink(receiveCompletion: {
                switch $0 {
                case .finished:
                    break
                case .failure(let error):
                    completion.append(error)
                }
            }, receiveValue: { (value: Artist) in
                values.append(value)
            })
            .store(in: &cancellables)

        // When
        testScheduler.schedule(after: testScheduler.now.advanced(by: 1)) {
            self.networkSessionSpy.stubbedResult?(.failure(URLError(.badURL)))
        }

        testScheduler.run()

        // Then
        XCTAssertEqual(values, [])
        XCTAssertEqual(completion as? [URLError], [URLError(.badURL)])
    }
}
