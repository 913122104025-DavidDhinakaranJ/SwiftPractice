protocol StringEnumMapper {
    associatedtype EnumCase: Hashable
    static var mappings: [EnumCase: String] { get }
}

extension StringEnumMapper {
    private static var reversedMappings: [String: EnumCase] {
        Dictionary(uniqueKeysWithValues: mappings.map {($0.value, $0.key)})
    }
    
    static func toString(_ enumCase: EnumCase) -> String {
        mappings[enumCase]!
    }
    
    static func toEnumCase(_ string: String) -> EnumCase {
        reversedMappings[string]!
    }
}
