public protocol AuthController: AnyObject {
    func handleRegistration(username: String, password: String) throws(AuthError) -> any AuthenticatableUser
    func handleLogin(username: String, password: String) throws(AuthError) -> any AuthenticatableUser
    func changePassword(username: String, oldPassword: String, newPassword: String) throws(AuthError)
}
