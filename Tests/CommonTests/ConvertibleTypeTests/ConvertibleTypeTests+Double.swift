import Foundation
import XCTest
@testable import Common

extension ConvertibleTypeTests {
    func testDouble() throws {
        let tests: [(type: ConvertibleType.Type, input: Any, expectedOutput: AnyEquatable?)] = [
            (Double.self,  "testing 1 2 3",    nil),
            (Double.self,  42,               AnyEquatable(42.0 as Double)),
            (Double.self,  "42",             AnyEquatable(42.0 as Double)),
            (Double.self,  true,             AnyEquatable(1.0 as Double)),
            (Double.self,  false,            AnyEquatable(0.0 as Double)),
            (Double.self,  1.0 as Float,     AnyEquatable(1.0 as Double)),
            (Double.self,  1.0 as Double,    AnyEquatable(1.0 as Double)),
            ]
        
        for (type, input, expectedOutput) in tests {
            do {
                let output = try type.make(from: input)
                XCTAssertTrue(expectedOutput!.equals(output), "\nINPUT: \(input) != \(output) : Expected: \(expectedOutput!.value)")
            } catch {
                if (expectedOutput != nil) { XCTFail() }
            }
        }
    }
}
