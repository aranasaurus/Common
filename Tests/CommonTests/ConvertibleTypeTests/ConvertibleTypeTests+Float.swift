import Foundation
import XCTest
@testable import Common

extension ConvertibleTypeTests {
    func testFloat() throws {
        let tests: [(type: ConvertibleType.Type, input: Any, expectedOutput: AnyEquatable?)] = [
            (Float.self,  "testing 1 2 3",    nil),
            (Float.self,  42,               AnyEquatable(42.0 as Float)),
            (Float.self,  "42",             AnyEquatable(42.0 as Float)),
            (Float.self,  true,             AnyEquatable(1.0 as Float)),
            (Float.self,  false,            AnyEquatable(0.0 as Float)),
            (Float.self,  1.0 as Float,     AnyEquatable(1.0 as Float)),
            (Float.self,  1.0 as Double,    AnyEquatable(1.0 as Float)),
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
