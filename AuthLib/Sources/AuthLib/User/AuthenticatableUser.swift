public protocol AuthenticatableUser {
    func getUserName() -> String
    func validate(password: String) -> Bool
    func changePassword(newPassword: String)
}
