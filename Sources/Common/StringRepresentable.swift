import Foundation

/// An abstraction that represents an item that can be represented as a `String`
public protocol StringRepresentable {
    /// Convert this type into a `String` if possible
    func makeString() -> String?
}
extension String: StringRepresentable {
    public func makeString() -> String? {
        return self
    }
}
public extension StringRepresentable {
    public func makeString() -> String? {
        return String(self)
    }
}
public extension StringRepresentable where Self: RawRepresentable {
    public func makeString() -> String? {
        guard let value = self.rawValue as? StringRepresentable else { return nil }
        return value.makeString()
    }
}
