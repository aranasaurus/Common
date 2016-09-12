
/// Describes a range of errors that can occur when attempting to convert one type to another
public enum ConvertibleTypeError: Error, CustomStringConvertible {
    /// Unable to convert the passed value to the required type
    case unableToConvert(from: Any.Type, to: Any.Type)
    
    public var description: String {
        switch self {
        case .unableToConvert(let from, let to):
            return "Unable to convert from \(String(describing: from)) to \(String(describing: to))"
        }
    }
}

/// An abstraction that represents a type that can be build from a range of other types
public protocol ConvertibleType {
    /**
     Attempt to create an instance of `Self` from the provided data
     
     - parameter from: The source data
     - throws: A `ConvertibleTypeError` with failure details
     - returns: The value converted to `Self` if conversion is successful
     */
    static func make(from value: Any) throws -> Self
}
extension ConvertibleType {
    static func tryConvert<T, U>(_ value: T) throws -> U {
        return try tryConvert(value, { $0 as? U })
    }
    static func tryConvert<T, U>(_ value: T, _ function: (T) -> U?) throws -> U {
        guard let converted = function(value)
            else { throw ConvertibleTypeError.unableToConvert(from: type(of: value), to: U.self) }
        
        return converted
    }
}
extension Bool: ConvertibleType {
    public static func make(from value: Any) throws -> Bool {
        switch value {
        case let value as String where ["1", "y", "yes", "t", "true"].contains(value): return true
        case let value as String where ["0", "n", "no", "f", "false"].contains(value): return false
        case let value as Int where value == 1: return true
        case let value as Int where value == 0: return false
        default: return false //try self.tryConvert(value)
        }
    }
}
extension String: ConvertibleType {
    public static func make(from value: Any) throws -> String {
        return String(describing: value)
    }
}
extension Int: ConvertibleType {
    public static func make(from value: Any) throws -> Int {
        switch value {
        case let value as String: return try self.tryConvert(value, Int.init)
        case let value as Bool: return (value ? 1 : 0)
        default: return try self.tryConvert(value)
        }
    }
}
extension Float: ConvertibleType {
    public static func make(from value: Any) throws -> Float {
        switch value {
        case let value as String: return try self.tryConvert(value, Float.init)
        case let value as Bool: return (value ? 1 : 0)
        default: return try self.tryConvert(value)
        }
    }
}
extension Double: ConvertibleType {
    public static func make(from value: Any) throws -> Double {
        switch value {
        case let value as String: return try self.tryConvert(value, Double.init)
        case let value as Bool: return (value ? 1 : 0)
        default: return try self.tryConvert(value)
        }
    }
}
