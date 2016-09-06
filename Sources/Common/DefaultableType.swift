
public protocol DefaultableType {
    static var `default`: Self { get }
}

extension String: DefaultableType {
    public static var `default`: String { return "" }
}
extension Int: DefaultableType {
    public static var `default`: Int { return 0 }
}
extension Float: DefaultableType {
    public static var `default`: Float { return 0 }
}
extension Double: DefaultableType {
    public static var `default`: Double { return 0 }
}
extension Bool: DefaultableType {
    public static var `default`: Bool { return false }
}
