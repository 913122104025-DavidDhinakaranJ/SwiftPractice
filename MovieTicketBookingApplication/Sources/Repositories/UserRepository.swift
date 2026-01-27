import Models
import AuthLib

public protocol UserRepository: AuthenticatableUserRepository {
    func getAll(role: User.Role) -> [User]
}
