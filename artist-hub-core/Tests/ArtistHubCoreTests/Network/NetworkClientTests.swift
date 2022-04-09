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

    func test_whenSessionReturnsError_shouldReportItDownstream() {
        // Given
        var completion: [Error] = []
        var values = [TestModel]()
        sut.request(for: "https://example.com")
            .sink(receiveCompletion: {
                switch $0 {
                case .finished:
                    break
                case .failure(let error):
                    completion.append(error)
                }
            }, receiveValue: { (value: TestModel) in
                values.append(value)
            })
            .store(in: &cancellables)

        // When
        testScheduler.schedule(after: testScheduler.now.advanced(by: 1)) {
            self.networkSessionSpy.stubbedResult?(.failure(URLError(.callIsActive)))
        }

        testScheduler.run()

        // Then
        XCTAssertEqual(networkSessionSpy.capturedRequest, [URLRequest(url: URL(string: "https://example.com")!)])
        XCTAssertEqual(values, [])
        XCTAssertEqual(completion as? [URLError], [URLError(.callIsActive)])
    }

    func test_whenURLisMalformed_shouldReportItDownstream() {
        // Given
        var completion: [Error] = []
        var values = [TestModel]()
        sut.request(for: "<malformed-url>")
            .sink(receiveCompletion: {
                switch $0 {
                case .finished:
                    break
                case .failure(let error):
                    completion.append(error)
                }
            }, receiveValue: { (value: TestModel) in
                values.append(value)
            })
            .store(in: &cancellables)

        // When
        testScheduler.run()

        // Then
        XCTAssertEqual(networkSessionSpy.capturedRequest, [])
        XCTAssertEqual(values, [])
        XCTAssertEqual(completion as? [URLError], [URLError(.badURL)])
    }

    func test_whenResponseCodeIsNot200OK_shouldReportBadResponseError() {
        // Given
        let dummyData = Data(capacity: 1)
        var completion: [Error] = []
        var values = [TestModel]()
        sut.request(for: "https://example.com")
            .sink(receiveCompletion: {
                switch $0 {
                case .finished:
                    break
                case .failure(let error):
                    completion.append(error)
                }
            }, receiveValue: { (value: TestModel) in
                values.append(value)
            })
            .store(in: &cancellables)

        // When
        testScheduler.schedule(after: testScheduler.now.advanced(by: 1)) {
            self.networkSessionSpy.stubbedResult?(.success((dummyData, HTTPURLResponse.info)))
        }

        testScheduler.run()

        // Then
        XCTAssertEqual(networkSessionSpy.capturedRequest, [URLRequest(url: URL(string: "https://example.com")!)])
        XCTAssertEqual(values, [])
        XCTAssertEqual(completion as? [URLError], [URLError(.badServerResponse)])
    }

    func test_whenResponseCanBeDecoded_shouldReportSuccess() {
        // Given
        var completion: [Error] = []
        var values = [TestModel]()
        sut.request(for: "https://example.com")
            .sink(receiveCompletion: {
                switch $0 {
                case .finished:
                    break
                case .failure(let error):
                    completion.append(error)
                }
            }, receiveValue: { (value: TestModel) in
                values.append(value)
            })
            .store(in: &cancellables)

        let json = """
        {
            "id": "<id>",
            "name": "<name>"
        }
        """
        let data = json.data(using: .utf8)!


        // When
        testScheduler.schedule(after: testScheduler.now.advanced(by: 1)) {
            self.networkSessionSpy.stubbedResult?(.success((data, HTTPURLResponse.ok)))
        }

        testScheduler.run()

        // Then
        XCTAssertEqual(networkSessionSpy.capturedRequest, [URLRequest(url: URL(string: "https://example.com")!)])
        XCTAssertEqual(values, [TestModel(id: "<id>", name: "<name>")])
        XCTAssertTrue(completion.isEmpty)
    }

    func test_responseIsMalformed_shouldReportParseError() {
        // Given
        var completion: [Error] = []
        var values = [TestModel]()
        sut.request(for: "https://example.com")
            .sink(receiveCompletion: {
                switch $0 {
                case .finished:
                    break
                case .failure(let error):
                    completion.append(error)
                }
            }, receiveValue: { (value: TestModel) in
                values.append(value)
            })
            .store(in: &cancellables)

        let json = """
        {
            "malformed...
            "id": "<id>",
            "name": "<name>"
        }
        """
        let data = json.data(using: .utf8)!


        // When
        testScheduler.schedule(after: testScheduler.now.advanced(by: 1)) {
            self.networkSessionSpy.stubbedResult?(.success((data, HTTPURLResponse.ok)))
        }

        testScheduler.run()

        // Then
        XCTAssertEqual(networkSessionSpy.capturedRequest, [URLRequest(url: URL(string: "https://example.com")!)])
        XCTAssertEqual(values, [])
        let decodingError = completion.first! as! DecodingError
        if case .dataCorrupted = decodingError {
            // no-op
        }  else {
            XCTFail("Wrong type")
        }
    }

    func test_tryToParseToIncompleteModel_shouldReportSuccess() {
        // Given
        var completion: [Error] = []
        var values = [TestIncompleteModel]()
        sut.request(for: "https://example.com")
            .sink(receiveCompletion: {
                switch $0 {
                case .finished:
                    break
                case .failure(let error):
                    completion.append(error)
                }
            }, receiveValue: { (value: TestIncompleteModel) in
                values.append(value)
            })
            .store(in: &cancellables)

        let json = """
        {
            "id": "<id>",
            "name": "<name>"
        }
        """
        let data = json.data(using: .utf8)!


        // When
        testScheduler.schedule(after: testScheduler.now.advanced(by: 1)) {
            self.networkSessionSpy.stubbedResult?(.success((data, HTTPURLResponse.ok)))
        }

        testScheduler.run()

        // Then
        XCTAssertEqual(networkSessionSpy.capturedRequest, [URLRequest(url: URL(string: "https://example.com")!)])
        XCTAssertEqual(values, [TestIncompleteModel(id: "<id>")])
        XCTAssertTrue(completion.isEmpty)
    }

    func test_tryToParseToWrongModel_shouldReportParseError() {
        // Given
        var completion: [Error] = []
        var values = [TestWrongModel]()
        sut.request(for: "https://example.com")
            .sink(receiveCompletion: {
                switch $0 {
                case .finished:
                    break
                case .failure(let error):
                    completion.append(error)
                }
            }, receiveValue: { (value: TestWrongModel) in
                values.append(value)
            })
            .store(in: &cancellables)

        let json = """
        {
            "id": "<id>",
            "name": "<name>"
        }
        """
        let data = json.data(using: .utf8)!


        // When
        testScheduler.schedule(after: testScheduler.now.advanced(by: 1)) {
            self.networkSessionSpy.stubbedResult?(.success((data, HTTPURLResponse.ok)))
        }

        testScheduler.run()

        // Then
        XCTAssertEqual(networkSessionSpy.capturedRequest, [URLRequest(url: URL(string: "https://example.com")!)])
        XCTAssertEqual(values, [])
        let decodingError = completion.first! as! DecodingError
        if case .keyNotFound = decodingError {
            // no-op
        }  else {
            XCTFail("Wrong type")
        }
    }
}

// MARK: - Helpers

private struct TestModel: Equatable, Decodable {
    let id: String
    let name: String
}

private struct TestIncompleteModel: Equatable, Decodable {
    let id: String
}

private struct TestWrongModel: Equatable, Decodable {
    let ids: String
    let name: String
}
