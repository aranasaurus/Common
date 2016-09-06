
public protocol Identifiable: Equatable {
    var id: String { get }
}
public func ==<T: Identifiable>(lhs: T, rhs: T) -> Bool {
    return lhs.id == rhs.id
}
