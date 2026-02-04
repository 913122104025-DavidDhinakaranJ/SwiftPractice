import AuthLib
import Models
import SQLite


extension SQLiteRepository: UserRepository {
    public func getAll(role: User.Role) -> [User] {
        
    }
    
    public func save(user: any AuthenticatableUser) {
        <#code#>
    }
    
    public func find(user: String) -> (any AuthenticatableUser)? {
        <#code#>
    }
    
    public func isUser(withName username: String) -> Bool {
        <#code#>
    }
}
