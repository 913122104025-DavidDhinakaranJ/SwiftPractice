public final class Admin: User {
    public enum Privilege: CaseIterable {
        case theatre, show, movie, customer, admin
    }
    
    public private(set) var privileges: Set<Privilege> = []
    
    public init(username: String, password: String) {
        super.init(username: username, password: password, role: .admin)
    }
    
    public convenience init(username: String, password: String, superAdmin: Bool) {
        self.init(username: username, password: password)
        superAdmin ? privileges.formUnion(Privilege.allCases) : ()
    }
    
    private init(username: String, password: String, privileges: Set<Privilege>, isBlocked: Bool) {
        self.privileges = privileges
        super.init(username: username, password: password, role: .admin)
        if isBlocked { super.block() }
    }
    
    public static func rehydrate(username: String, password: String, privileges: [Privilege], isBlocked: Bool) -> Admin {
        .init(username: username, password: password, privileges: Set(privileges), isBlocked: isBlocked)
    }
    
    public func grant(_ privilege: Privilege) {
        privileges.insert(privilege)
    }
    
    public func revoke(_ privilege: Privilege) {
        privileges.remove(privilege)
    }
    
    public func hasPrivilege(_ privilege: Privilege) -> Bool {
        privileges.contains(privilege)
    }
}
