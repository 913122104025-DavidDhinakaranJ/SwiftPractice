struct ConsoleAuthInputUtil {
    static func readUserName(prompt: String = "Enter Username", isValidationEnabled: Bool = false) -> String {
        readInput: while true {
            print(prompt, terminator: ": ")
            let username = readLine() ?? ""
            if !isValidationEnabled { return username }
            
            for char in username {
                if !char.isLetter && !char.isNumber {
                    displayError("Username must only contain letters and numbers.")
                    continue readInput
                }
            }
            
            if username.count < 4 && username.count > 20 {
                displayError("Username must be between 4 and 20 characters long.")
                continue readInput
            }
            
            return username
        }
    }
    
    static func readPassword(prompt: String = "Enter password", isValidationEnabled: Bool = false) -> String {
        let MIN_PASSWORD_LENGTH = 8
        let MAX_PASSWORD_LENGTH = 64
        let SPECIAL_CHARACTERS = "@$!%*?&"
        while true {
            print(prompt, terminator: ": ")
            let password = readLine() ?? ""
            if !isValidationEnabled { return password }
            
            if password.count < MIN_PASSWORD_LENGTH {
                displayError("Password must be at least 8 characters long.")
            } else if password.count > MAX_PASSWORD_LENGTH {
                displayError("Password must be at most 64 characters long.")
            } else if !password.contains(where: \.isUppercase) {
                displayError("Password must contain at least one uppercase letter.")
            } else if !password.contains(where: \.isLowercase) {
                displayError("Password must contain at least one lowercase letter.")
            } else if !password.contains(where: \.isNumber) {
                displayError("Password must contain at least one numeric digit (0-9).")
            } else if !password.contains(where: { SPECIAL_CHARACTERS.contains($0) }) {
                displayError("Password must contain at least one special character (\(SPECIAL_CHARACTERS)).")
            } else if password.contains(" ") {
                displayError("Password must not contain spaces.")
            } else {
                return password
            }
        }
    }
    
    private static func displayError(_ error: String) {
        print("Error: \(error)")
    }
}
