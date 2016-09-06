import Foundation

public extension Dictionary {
    public init<S: Sequence where S.Iterator.Element == (Key, Value)>(_ tuples: S) {
        self.init()
        
        for (key, value) in tuples {
            self[key] = value
        }
    }
}

public func +<Key, Value>(lhs: [Key: Value]?, rhs: [Key: Value]?) -> [Key: Value] {
    let lhs = lhs ?? [:]
    let rhs = rhs ?? [:]
    
    var result = lhs
    result.append(contentsOf: rhs)
    return result
}

public extension Dictionary {
    /**
     Adds the elements of another dictionary with the same `Key` and `Value` to the dictionary.
     
     NOTE: If the other dictionary has keys that already exist in this dictionary then will be replaced.
     
     - parameter other: The `Dictionary<Key, Value>` to append.
     */
    public mutating func append(contentsOf other: Dictionary<Key, Value>) {
        for (key, value) in other {
            self.updateValue(value, forKey: key)
        }
    }
}

//public extension Dictionary where Key: StringType, Value: Any {
//    public func makeString() -> String? {
//        let input = self.map { key, value -> (String, Any) in
//            return (key.string, value)
//        }
//        let dict = Dictionary<String, Any>(input)
//        
//        guard
//            let data = try? JSONSerialization.jsonData(with: dict),
//            let string = String(data: data, encoding: .utf8)
//            else { return nil }
//        
//        return string
//    }
//}
