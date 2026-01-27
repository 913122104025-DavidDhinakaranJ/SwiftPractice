import AuthLib

public struct AdminFactory: AuthenticatableUserFactory {
    public init() {}
    public func createUser(username: String, password: String) -> any AuthenticatableUser {
        Admin(username: username, password: password)
    }
}
