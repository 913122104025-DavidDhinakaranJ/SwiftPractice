import AuthLib

public class User: AuthenticatableUser {
    public enum Role { case customer, admin }
    public let username: String
    private var password: String
    public let role: Role
    public private(set) var isBlocked: Bool = false
    
    public init(username: String, password: String, role: Role) {
        self.username = username
        self.password = password
        self.role = role
    }
    
    public func validate(password: String) -> Bool {
        self.password == password
    }
    
    public func changePassword(newPassword: String) {
        self.password = newPassword
    }
    
    public func block() {
        isBlocked = true
    }
    
    public func unblock() {
        isBlocked = false
    }
}
