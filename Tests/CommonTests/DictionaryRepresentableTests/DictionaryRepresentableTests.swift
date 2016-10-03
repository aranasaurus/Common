import Foundation
import XCTest
@testable import Common

extension TestModel: DictionaryRepresentable { }
extension NestedModel: DictionaryRepresentable { }

func stringify(_ dict: [String: Any], level: Int = 0) -> String {
    var result = ""
    
    for key in dict.keys.sorted() {
        guard let value = dict[key] else { continue }
        result += "[\(level):\(key)="
        defer { result += "]" }
        
        switch value {
        case let value as [String: Any]:
            result += stringify(value, level: level + 1)
        case let value as [[String: Any]]:
            result += value.reduce("") { $0 + stringify($1, level: level + 1) }
        default:
            result += String(describing: value)
        }
    }
    
    return result
}

class DictionaryRepresentableTests: XCTestCase {
    static let allTests = [
        ("testDictionarySerialisation", testDictionarySerialisation),
    ]
    
    func modelInstance() -> TestModel {
        return TestModel(
            optionalString: nil,
            string: "foo",
            bool: true,
            int: 42,
            double: 42.42,
            float: 24.24,
            nestedSingle: NestedModel(
                optionalString: "optional",
                string: "bar",
                bool: false,
                int: 4242,
                double: 2.42,
                float: 4.24
            ),
            nestedCollection: [
                NestedModel(
                    optionalString: "optional",
                    string: "foo",
                    bool: true,
                    int: 42,
                    double: 42.42,
                    float: 24.24
                ),
                NestedModel(
                    optionalString: nil,
                    string: "foo",
                    bool: true,
                    int: 42,
                    double: 42.42,
                    float: 24.24
                )
            ]
        )
    }
    
    func testDictionarySerialisation() throws {
        let model = modelInstance()
        
        let result = model.makeDictionary()
        
        XCTAssertEqual(
            stringify(result),
            stringify([
                "string": "foo",
                "bool": true,
                "int": 42,
                "double": 42.42,
                "float": 24.24,
                "nestedSingle": [
                    "optionalString": "optional",
                    "string": "bar",
                    "bool": false,
                    "int": 4242,
                    "double": 2.42,
                    "float": 4.24,
                ],
                "nestedCollection": [
                    [
                        "optionalString": "optional",
                        "string": "foo",
                        "bool": true,
                        "int": 42,
                        "double": 42.42,
                        "float": 24.24,
                    ],
                    [
                        "string": "foo",
                        "bool": true,
                        "int": 42,
                        "double": 42.42,
                        "float": 24.24,
                    ]
                ]
            ])
        )
    }
}
