import XCTest
import Combine
@testable import ArtistHubCore

class NetworkClientTests: XCTestCase {

    var networkSessionSpy: NetworkSessionSpy!
    var sut: NetworkClient!

    override func setUp() {
        super.setUp()
        networkSessionSpy = .init()
        sut = .init(networkSession: networkSessionSpy)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        networkSessionSpy = nil
    }

    func test_whenPublisherReturnsError_shouldBeReported() {

        let expectation = XCTestExpectation(description: "A")
        let c = sut
        .request(for: "https://google.com")
        .sink(receiveCompletion: {
            print("completion \($0)")
            expectation.fulfill()
        }, receiveValue: { (value: [Artist]) in
            print("value: \(value)")
            expectation.fulfill()
        })

        networkSessionSpy.publisher?.stubbedResult?.receive(completion: Subscribers.Completion.failure(URLError(.badURL)))

        wait(for: [expectation], timeout: 1.0)
    }
}
