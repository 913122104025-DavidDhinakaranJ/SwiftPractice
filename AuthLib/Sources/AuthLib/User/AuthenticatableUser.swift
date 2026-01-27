public protocol AuthenticatableUser {
    var username: String { get }
    func validate(password: String) -> Bool
    func changePassword(newPassword: String)
}
