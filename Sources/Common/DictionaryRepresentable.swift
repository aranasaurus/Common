
public protocol DictionaryRepresentable {
    func makeDictionary() -> [String: Any]
}
public protocol DictionaryValueRepresentable {
    var dictionaryValue: Any? { get }
}
public extension DictionaryValueRepresentable {
    public var dictionaryValue: Any? { return self }
}
public extension DictionaryValueRepresentable where Self: RawRepresentable {
    public var dictionaryValue: Any? { return self.rawValue }
}
extension Mirror {
    func makeDictionary() -> [String: Any] {
        let output: [String: Any] = self.children.reduce([:]) { result, child in
            guard
                let key = child.label,
                let value = self.getValue(from: child)
                else { return result }
            
            let output = result + [key: value]
            
            if let superClassMirror = self.superclassMirror {
                return output + superClassMirror.makeDictionary()
            }
            
            return output
        }
        
        return output
    }
    
    private func getValue(from child: Child) -> Any? {
        let childMirror = Mirror(reflecting: child.value)
        let childStyle = childMirror.displayStyle
        
        switch childStyle {
        case .some(.collection):
            let value = childMirror.children.flatMap { self.getValue(from: $0) }
            return value
            
        case .some(.optional):
            if let child = childMirror.children.first {
                return self.getValue(from: child)
            }
            
        default:
            if let value = child.value as? DictionaryRepresentable {
                return value.makeDictionary()
                
            } else if let item = child.value as? DictionaryValueRepresentable {
                return item.dictionaryValue
                
            } else {
                print("Unhandled: \(childStyle): \(child)")
            }
        }
        return nil
    }
}
public extension DictionaryRepresentable {
    public func makeDictionary() -> [String: Any] {
        return Mirror(reflecting: self).makeDictionary()
    }
}
