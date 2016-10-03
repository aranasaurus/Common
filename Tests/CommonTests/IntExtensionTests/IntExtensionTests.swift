import Foundation
import XCTest
@testable import Common

class IntExtensionTests: XCTestCase {
    static let allTests = [
        ("testIntBetween", testIntBetween),
    ]
    
    func testIntBetween() throws {
        //inside
        XCTAssertTrue(5.between(1, and: 10, .inclusive))
        XCTAssertTrue(5.between(1, and: 10, .exclusive))
        
        //outside
        XCTAssertFalse(15.between(1, and: 10, .inclusive))
        XCTAssertFalse(15.between(1, and: 10, .exclusive))
        
        //borders
        XCTAssertTrue(1.between(1, and: 10, .inclusive))
        XCTAssertFalse(1.between(1, and: 10, .exclusive))
        XCTAssertTrue(10.between(1, and: 10, .inclusive))
        XCTAssertFalse(10.between(1, and: 10, .exclusive))
        
        //edge
        XCTAssertFalse(0.between(1, and: 10, .inclusive))
        XCTAssertFalse(0.between(1, and: 10, .exclusive))
    }
}
