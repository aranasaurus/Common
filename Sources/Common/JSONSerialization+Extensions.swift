import Foundation

public extension JSONSerialization {
    public static func json(with data: Data, options opt: JSONSerialization.ReadingOptions = []) throws -> [String: Any]? {
        #if os(Linux)
            return try self.jsonObject(with: data, options: opt) as? [String: Any]
        #else
            guard let nsResult = try self.jsonObject(with: data, options: opt) as? [String: AnyObject] else { return nil }
            
            var dict = [String: Any]()
            for (key, value) in nsResult {
                dict[key as String] = value as Any
            }

            return dict
        #endif
    }
    public static func data(from json: AnyObject, options opt: JSONSerialization.WritingOptions = []) throws -> Data {
        return try self.data(withJSONObject: json, options: opt)
    }
}
