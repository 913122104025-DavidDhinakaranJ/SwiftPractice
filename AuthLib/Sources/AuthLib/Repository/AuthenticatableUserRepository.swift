public protocol AuthenticatableUserRepository {
    func save(user: AuthenticatableUser)
    func find(user: String) -> (any AuthenticatableUser)?
    func isUserexists(withName username: String) -> Bool
}
