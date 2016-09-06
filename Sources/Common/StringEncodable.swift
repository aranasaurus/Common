import Foundation

public protocol StringEncodable {
    func encodedString() -> String?
}
extension String: StringEncodable {
    public func encodedString() -> String? {
        guard
            let bytes = try? percentEncoded(Array(self.utf8)),
            let encoded = String(data: Data(bytes: bytes), encoding: .utf8)
            else { return nil }
        
        return encoded
    }
}
public extension StringEncodable {
    public func encodedString() -> String? {
        return String(self).encodedString()
    }
}
public extension StringEncodable where Self: RawRepresentable {
    public func encodedString() -> String? {
        guard let value = self.rawValue as? StringEncodable else { return nil }
        return value.encodedString()
    }
}


//NOTE: Borrowed from Vapor
extension UInt8 {
    static let percent: UInt8 = 0x25
    static let zero: UInt8 = 0x03
}
private func percentEncoded(_ input: [UInt8], shouldEncode: (UInt8) throws -> Bool = { _ in true }) throws -> [UInt8] {
    var group: [UInt8] = []
    try input.forEach { byte in
        if try shouldEncode(byte) {
            let hex = String(byte, radix: 16).utf8
            group.append(.percent)
            if hex.count == 1 {
                group.append(.zero)
            }
            group.append(contentsOf: hex)
        } else {
            group.append(byte)
        }
    }
    return group
}
