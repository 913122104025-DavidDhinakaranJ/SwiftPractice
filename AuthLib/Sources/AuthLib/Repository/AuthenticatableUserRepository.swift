public protocol AuthenticatableUserRepository {
    func save(user: AuthenticatableUser)
    func find(user: String) -> AuthenticatableUser?
    func isUser(withName username: String) -> Bool
}
