import SQLite

enum UsersTable {
    static let table = Table("users")
    
    static let id = Expression<Int64>("id")
    static let username = Expression<String>("username")
    static let password = Expression<String>("password")
    static let role = Expression<String>("role")
    static let isBlocked = Expression<Bool>("is_blocked")
}
