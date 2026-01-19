//private < fileprivate < internal < package < public < open
//Public access control
public struct PublicStructure {
    public var publicProperty = "Public"
    var internalProperty = "Internal"
    fileprivate var filePrivateProperty = "File Private"
    private var privateProperty = "Private"
}

//Internal access control
struct InternalStructure {
    var internalProperty = "Internal"
    fileprivate var filePrivateProperty = "File Private"
    private var privateProperty = "Private"
}

//File-Private access control
struct FilePrivateStructure {
    var filePrivateProperty = "File Private"  //implicitly file-private
    private var privateProperty = "Private"
}

//Private access control
private struct PrivateStructure {
    var privateProperty = "Private"  //implicitly private
}

//Access Control of Tuples
// A tuple must have access level less than or equal to the most restrictive access level of all types used in that tuple.
private let privateTuple = (PublicStructure(), FilePrivateStructure())

//Access Control of Functions
// A function must have access level less than or equal to the most restrictive access level of the function’s parameter types and return type.
private func privateFunction(_ privateParameter: PrivateStructure, _ internalParameter: InternalStructure) -> PublicStructure {
    return PublicStructure()
}

//Access Control in Enumerations
//The types used for any raw values or associated values in an enumeration definition must have an access level at least as high as the enumeration’s access level.
private enum PrivateEnum {
    case publicCase(PublicStructure)
    case privateCase(PrivateStructure)
    case internalCase(InternalStructure)
    case filePrivateCase(FilePrivateStructure)
}

//Subclassing
open class OpenSuperclass {
    open var openProperty: String { "Open" }
    public required init(flag: Bool) {}
}

private class PrivateSubclass: OpenSuperclass {
    //Required Visibility = min(Superclass Property Visibility, Current Subclass Visibility)
    override fileprivate var openProperty: String { "Overridden Private" }
    
    private init() { super.init(flag: false) }
    
    fileprivate required init(flag: Bool) { super.init(flag: flag) }
}

//Getters and Setters
struct TrackedString {
    private(set) var numberOfEdits: Int = 0
    var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
}

var text = TrackedString()
text.value = "Hello, World!"
text.value += "!"
text.numberOfEdits

//Protocols
public protocol Identifiable {
    var id: String { get }
}

//Protocol Inheritance - must have visibility less than or equal to existing protocol
protocol Named: Identifiable {
    var name: String { get }
}

public struct Person: Named {
    //Required Visibility = min(Protocol Visibility, Current Type Visibility)
    public var id: String
    var name: String
}

//Extension
private extension Person {
    var description: String {
        "Person(id: \(id), name: \(name))"
    }
}
