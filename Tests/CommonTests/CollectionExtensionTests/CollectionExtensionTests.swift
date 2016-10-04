import Foundation
import XCTest
@testable import Common

class CollectionExtensionTests: XCTestCase {
    static let allTests = [
        ("testRandomElement", testRandomElement),
        ]

    func testRandomElement() throws {
        let source = Array(1..<10)
        var received = [Int]()

        // Call it a bunch of times and make sure it never crashes.
        for _ in 0..<1000 {
            received.append(source.randomElement)
        }

        // Make sure every element was returned at least once
        for s in source {
            XCTAssert(received.contains(s))
        }
    }
}
