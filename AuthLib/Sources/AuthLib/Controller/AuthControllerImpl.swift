public class AuthControllerImpl: AuthController {
    private final var userRepository: AuthenticatableUserRepository
    private final var factory: AuthenticatableUserFactory
    
    public init(userRepository: AuthenticatableUserRepository, factory: AuthenticatableUserFactory) {
        self.userRepository = userRepository
        self.factory = factory
    }
    
    public func handleRegistration(username: String, password: String) throws(AuthError) -> any AuthenticatableUser {
        if userRepository.isUser(withName: username) { throw .userAlreadyExists }
        
        let newUser = factory.createUser(username: username, password: password)
        userRepository.save(user: newUser)
        
        return newUser
    }
    
    public func handleLogin(username: String, password: String) throws(AuthError) -> any AuthenticatableUser {
        let user = userRepository.find(user: username)
        
        if user == nil { throw .userNotFound }
        if !user!.validate(password: password) { throw .incorrectPassword }
        
        return user!
    }
    
    public func changePassword(username: String, oldPassword: String, newPassword: String) throws(AuthError) {
        let user = userRepository.find(user: username)
        
        if user == nil { throw .userNotFound }
        if !user!.validate(password: oldPassword) { throw .incorrectPassword }
        
        user!.changePassword(newPassword: newPassword)
        userRepository.save(user: user!)
    }
}
