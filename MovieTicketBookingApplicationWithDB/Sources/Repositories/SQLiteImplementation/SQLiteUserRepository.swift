import AuthLib
import Models
import SQLite

extension SQLiteRepository: UserRepository {
    public func getAll(role: User.Role) -> [User] {
        do {
            return try db.prepare(UsersTable.table.filter(UsersTable.role == UserRoleMapper.toString(role)))
                .map(makeUser)
        } catch {
            fatalError("Error in DB")
        }
    }
    
    public func save(user: any AuthenticatableUser) {
        guard let user = user as? User else { return }
        
        let insert = UsersTable.table.insert(
            UsersTable.username <- user.username,
            UsersTable.password <- user.passwordHashForStorage,
            UsersTable.role <- UserRoleMapper.toString(user.role)
        )
        
        do {
            try db.run(insert)
        } catch {
            fatalError("Error in DB")
        }
    }
    
    public func find(user: String) -> (any AuthenticatableUser)? {
        do {
            return try db.pluck(UsersTable.table.filter(UsersTable.username == user)).map(makeUser)
        } catch {
            fatalError("Error in DB")
        }
    }
    
    public func isUser(withName username: String) -> Bool {
        return find(user: username) != nil
    }
}
