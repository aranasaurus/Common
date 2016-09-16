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

extension JSON: DictionaryRepresentable {
    public func makeDictionary() -> [String : Any] {
        guard case .object(let object) = self else { return [:] }
        
        var result = [String: Any]()
        for (key, value) in object {
            guard let value = value.dictionaryValue else { continue }
            result[key] = value
        }
        return result
    }
}
extension JSON: DictionaryValueRepresentable {
    public var dictionaryValue: Any? {
        switch self {
        case .array(let array): return array.flatMap { $0.dictionaryValue }
        case .object: return self.makeDictionary()
        case .null: return nil
        case .number(let number):
            switch number {
            case .double(let value): return value
            case .integer(let value): return value
            case .unsignedInteger(let value): return Int(value)
            }
        case .boolean(let value): return value
        case .string(let value): return value
        }
    }
}
