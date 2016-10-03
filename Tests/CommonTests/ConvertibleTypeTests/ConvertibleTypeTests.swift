import Foundation
import XCTest
@testable import Common

class ConvertibleTypeTests: XCTestCase {
    static let allTests = [
        ("testString", testString),
        ("testBoolean", testBoolean),
        ("testInt", testInt),
        ("testFloat", testFloat),
        ("testDouble", testDouble),
    ]
}
