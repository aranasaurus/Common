import Foundation

public extension JSONSerialization {
    public static func json(with data: Data, options opt: JSONSerialization.ReadingOptions = []) throws -> [String: Any]? {
        #if os(Linux)
            return try self.jsonObject(with: data, options: opt) as? [String: Any]
        #else
            guard let nsResult = try self.jsonObject(with: data, options: opt) as? NSDictionary else { return nil }
            return Dictionary<String, Any>._bridgeFromObjectiveCAdoptingNativeStorageOf(nsResult)
        #endif
    }
    public static func data(from json: AnyObject, options opt: JSONSerialization.WritingOptions = []) throws -> Data {
        return try self.data(withJSONObject: json, options: opt)
    }
}
