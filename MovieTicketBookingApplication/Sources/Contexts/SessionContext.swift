import Models

public final class SessionContext {
    public private(set) var currentUser: User?
    
    public init() {}
    
    public func login(user: User) {
        currentUser = user
    }
    
    public func logout() {
        currentUser = nil
    }
}
