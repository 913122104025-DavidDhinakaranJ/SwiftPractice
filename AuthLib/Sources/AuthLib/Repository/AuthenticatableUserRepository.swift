public protocol AuthenticatableUserRepository {
    func save(user: AuthenticatableUser)
    func find(user: String) -> (any AuthenticatableUser)?
    func isUser(withName username: String) -> Bool
}
