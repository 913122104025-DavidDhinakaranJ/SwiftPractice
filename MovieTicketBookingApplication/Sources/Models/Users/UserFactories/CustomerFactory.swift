import AuthLib

public struct CustomerFactory: AuthenticatableUserFactory {
    public init() {}
    public func createUser(username: String, password: String) -> any AuthenticatableUser {
        Customer(username: username, password: password)
    }
}
