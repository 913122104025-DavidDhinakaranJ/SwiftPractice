import SQLite

enum AdminPrivilegesTable {
    static let table = Table("admin_privileges")
    
    static let adminId = Expression<Int64>("admin_id")
    static let privilege = Expression<String>("privilege")
}
