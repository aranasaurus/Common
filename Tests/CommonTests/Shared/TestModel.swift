
struct TestModel {
    var optionalString: String?
    var string: String
    var bool: Bool
    var int: Int
    var double: Double
    var float: Float
    
    var nestedSingle: NestedModel
    var nestedCollection: [NestedModel]
}

struct NestedModel {
    var optionalString: String?
    var string: String
    var bool: Bool
    var int: Int
    var double: Double
    var float: Float
}
