public class ConsoleAuthView {
    private final var authController: AuthController
    
    public init(authController: AuthController) {
        self.authController = authController
    }
    
    public func handleRegistration() -> (any AuthenticatableUser)? {
        let username = ConsoleAuthInputUtil.readUserName(isValidationEnabled: true)
        let password = ConsoleAuthInputUtil.readPassword(isValidationEnabled: true)
        
        do {
            let newUser = try authController.handleRegistration(username: username, password: password)
            return newUser
        } catch AuthError.userAlreadyExists {
            print("User with username \(username) already exists.")
        } catch {
            print("Unexpected error: \(error).")
        }
        
        return nil
    }
    
    public func handleLogin() -> (any AuthenticatableUser)? {
        let username = ConsoleAuthInputUtil.readUserName()
        let password = ConsoleAuthInputUtil.readPassword()
        
        do {
            let loggedInUser = try authController.handleLogin(username: username, password: password)
            return loggedInUser
        } catch AuthError.userNotFound {
            print("No user with username \(username) found.")
        } catch AuthError.incorrectPassword {
            print("Incorrect password.")
        } catch {
            print("Unexpected error: \(error).")
        }
        
        return nil
    }
    
    public func changePassword(for user: AuthenticatableUser) {
        let oldPassword = ConsoleAuthInputUtil.readPassword(prompt: "Enter your old password")
        var newPassword: String
        
        while true {
            newPassword = ConsoleAuthInputUtil.readPassword(prompt: "Enter a new password", isValidationEnabled: true)
            let newPasswordConfirmation = ConsoleAuthInputUtil.readPassword(prompt: "Confirm your new password")
            
            if newPassword != newPasswordConfirmation {
                print("New password and confirmation password do not match. Please try again.")
            } else {
                break
            }
        }
        
        do {
            try authController.changePassword(username: user.username, oldPassword: oldPassword, newPassword: newPassword)
            print("Password changed successfully.")
        } catch AuthError.incorrectPassword {
            print("Incorrect Old Password")
        } catch {
            print("Unexpected error: \(error).")
        }
    }
}
