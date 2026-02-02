import Models

extension Admin {
    public var detailedDescription: String {
        let status = isBlocked ? "🚫 Blocked" : "✅ Active"
        
        let privilegeList = privileges.isEmpty ? "None" : privileges.map { "\($0)".capitalized }.sorted().joined(separator: ", ")
        
        return """
        🛡️ ADMIN PROFILE
        --------------------------------
        Username:    \(username)
        Status:      \(status)
        Privileges:  \(privilegeList)
        --------------------------------
        """
    }
}
