
/**
 Describes a range of errors that can occur when attempting to access a `KeyPathAccessible` via `KeyPathComponent`s
 */
public enum KeyPathError: Error, CustomStringConvertible {
    /// The input was not valid
    case invalidInput
    
    /// The provided keypath was not found
    case invalidKeyPath(keyPath: [KeyPathComponent])
    
    /// A value was found but the type requested was not the type that was found
    case typeMismatch(keyPath: [KeyPathComponent], expected: Any.Type, got: Any.Type)
    
    public var description: String {
        switch self {
        case .invalidInput:
            return "The provided input was invalid"
        case .invalidKeyPath(let keyPath):
            return "Invalid keyPath provided: \(keyPath)"
        case .typeMismatch(let keyPath, let expected, let got):
            return "Type mismatch on keyPath: '\(keyPath)' - Expected: \(expected), got: \(got)"
        }
    }
}

public protocol KeyPathComponent { }
extension String: KeyPathComponent { }
extension Int: KeyPathComponent { }

public protocol KeyPathAccessible {
    func path(key: KeyPathComponent) throws -> KeyPathAccessible
    func value<T>(key: KeyPathComponent) throws -> T
}
public extension KeyPathAccessible {
    public func value<T>(at keyPath: [KeyPathComponent]) throws -> T {
        guard !keyPath.isEmpty else { throw KeyPathError.invalidInput }
        
        if keyPath.count == 1, let path = keyPath.first {
            return try self.value(key: path)
        }
        
        var components = keyPath
        
        do {
            let last = components.removeLast()
            let path = try components.reduce(self) { component, key -> KeyPathAccessible in
                return try component.path(key: key)
            }
            
            return try path.value(key: last)
            
        } catch let error as KeyPathError {
            switch error {
            case .invalidKeyPath:
                throw KeyPathError.invalidKeyPath(keyPath: keyPath)
                
            case .typeMismatch(_, let expected, let got):
                throw KeyPathError.typeMismatch(keyPath: keyPath, expected: expected, got: got)
                
            default: throw error
            }
            
        } catch let error { throw error }
    }
    public func valueExists<T>(at keyPath: [KeyPathComponent], type: T.Type, predicate: (T) -> Bool = { _ in true }) -> Bool {
        do {
            let value: T = try self.value(at: keyPath)
            return predicate(value)
        }
        catch { return false }
    }
}

extension Dictionary: KeyPathAccessible {
    public func path(key: KeyPathComponent) throws -> KeyPathAccessible {
        guard
            let keyValue = key as? Key,
            let path = self[keyValue] as? KeyPathAccessible
            else { throw KeyPathError.invalidKeyPath(keyPath: [key]) }
        
        return path
    }
    public func value<T>(key: KeyPathComponent) throws -> T {
        guard
            let keyValue = key as? Key,
            let value = self[keyValue]
            else { throw KeyPathError.invalidKeyPath(keyPath: [key]) }
        
        guard
            let castedValue = value as? T
            else { throw KeyPathError.typeMismatch(keyPath: [key], expected: T.self, got: value.dynamicType) }
        
        return castedValue
    }
}
extension Array: KeyPathAccessible {
    public func path(key: KeyPathComponent) throws -> KeyPathAccessible {
        guard
            let keyValue = key as? Index,
            let path = self[keyValue] as? KeyPathAccessible
            else { throw KeyPathError.invalidKeyPath(keyPath: [key]) }
        
        return path
    }
    public func value<T>(key: KeyPathComponent) throws -> T {
        guard
            let keyValue = key as? Index,
            self.indices.contains(keyValue)
            else { throw KeyPathError.invalidKeyPath(keyPath: [key]) }
        
        let value = self[keyValue]
        
        guard
            let castedValue = value as? T
            else { throw KeyPathError.typeMismatch(keyPath: [key], expected: T.self, got: value.dynamicType) }
        
        return castedValue
    }
}

#if !os(Linux)
    import Foundation
    extension NSArray: KeyPathAccessible {
        public func path(key: KeyPathComponent) throws -> KeyPathAccessible {
            return try (self as Array).path(key: key)
        }
        public func value<T>(key: KeyPathComponent) throws -> T {
            return try (self as Array).value(key: key)
        }
    }
    
    extension NSDictionary: KeyPathAccessible {
        public func path(key: KeyPathComponent) throws -> KeyPathAccessible {
            return try (self as Dictionary).path(key: key)
        }
        public func value<T>(key: KeyPathComponent) throws -> T {
            return try (self as Dictionary).value(key: key)
        }
    }
#endif
