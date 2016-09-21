
/// An abstraction that represents a `String`
/// essentially a small hack used in some of the Vapor related conversions
/// Will be removed once the conversions aren't required
public protocol StringType {
    var string: String { get }
}
extension String: StringType {
    public var string: String { return self }
}
