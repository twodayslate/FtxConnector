import XCTest
@testable import FtxConnector

final class ftx_connectorTests: XCTestCase {
    func testExample() async throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        //XCTAssertEqual(ftx_connector().text, "Hello, World!")
        let client = FtxConnector.restClient(key: ProcessInfo.processInfo.environment["FTX_KEY"]!, secret: ProcessInfo.processInfo.environment["FTX_SECRET"]!)
        let account = try await client.account()
        XCTAssertNotNil(account)
    }
}
