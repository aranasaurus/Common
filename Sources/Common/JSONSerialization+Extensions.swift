import Foundation

public extension JSONSerialization {
    public static func json(with data: Data, options opt: JSONSerialization.ReadingOptions = []) throws -> [String: Any]? {
        #if os(Linux)
            return try self.jsonObject(with: data, options: opt) as? [String: Any]
        #else
            guard let nsResult = try self.jsonObject(with: data, options: opt) as? [String: AnyObject] else { return nil }
            return nsDictToAny(nsResult)
        #endif
    }
    public static func data(from json: Any, options opt: JSONSerialization.WritingOptions = []) throws -> Data {
        return try self.data(withJSONObject: json, options: opt)
    }
}

private func nsDictToAny(_ dict: [String: AnyObject]) -> [String: Any] {
    var result = [String: Any]()
    let mirror = Mirror(reflecting: dict)
    
    for child in mirror.children {
        guard
            let pair = child.value as? (key: String, value: AnyObject)
            else { continue }
        
        if let value = pair.value as? [String: AnyObject] {
            result[pair.key] = nsDictToAny(value)
            
        } else if let value = pair.value as? [[String: AnyObject]] {
            result[pair.key] = value.map { nsDictToAny($0) }
            
        } else {
            result[pair.key] = pair.value as Any
        }
    }
    
    return result
}
