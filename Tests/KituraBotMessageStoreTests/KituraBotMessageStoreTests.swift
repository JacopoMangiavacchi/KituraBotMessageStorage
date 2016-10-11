import XCTest
@testable import KituraBotMessageStore

class KituraBotMessageStoreTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(KituraBotMessageStore().text, "Hello, World!")
    }


    static var allTests : [(String, (KituraBotMessageStoreTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
