import Foundation
import Jay

public extension JSONSerialization {
    public static func json(with data: Data, options opt: JSONSerialization.ReadingOptions = []) throws -> [String: Any] {
        let json = try Jay().jsonFromData(Array(data))
        return json.makeDictionary()
    }
    public static func data(from json: Any, options opt: JSONSerialization.WritingOptions = []) throws -> Data {
        let bytes = try Jay().dataFromJson(any: json)
        return Data(bytes: bytes)
    }
}
