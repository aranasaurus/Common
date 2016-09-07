
/// An abstraction that represents an item with a unique id that can be used to compare equality
public protocol Identifiable: Equatable {
    var id: String { get }
}
public func ==<T: Identifiable>(lhs: T, rhs: T) -> Bool {
    return lhs.id == rhs.id
}
