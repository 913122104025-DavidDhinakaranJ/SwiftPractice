public protocol AuthenticatableUserFactory {
    func createUser(username: String, password: String) -> any AuthenticatableUser
}
