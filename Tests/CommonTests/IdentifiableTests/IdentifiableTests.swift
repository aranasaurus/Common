import Foundation
import XCTest
@testable import Common

extension NestedModel: Identifiable {
    var id: String { return self.string }
}

class IdentifiableTests: XCTestCase {
    static let allTests = [
        ("testIdentifiableEquality", testIdentifiableEquality),
    ]
    
    func testIdentifiableEquality() throws {
        let first = NestedModel(
            optionalString: nil, string: "foo", bool: true,
            int: 1, double: 1.0, float: 1.0
        )
        let second = NestedModel(
            optionalString: nil, string: "bar", bool: true,
            int: 1, double: 1.0, float: 1.0
        )
        let third = NestedModel(
            optionalString: nil, string: "foo", bool: true,
            int: 1, double: 1.0, float: 1.0
        )
        
        XCTAssertEqual(first, third)
        XCTAssertNotEqual(first, second)
    }
}
