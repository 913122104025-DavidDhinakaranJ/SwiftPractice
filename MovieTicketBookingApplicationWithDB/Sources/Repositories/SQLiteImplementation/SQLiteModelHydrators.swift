import Models
import SQLite

extension SQLiteRepository {
    func makeUser(from row: Row) -> User {
        let role = UserRoleMapper.toEnumCase(row[UsersTable.role])
        
        return switch role {
        case .admin: makeAdmin(from: row)
        case .customer: makeCustomer(from: row)
        }
    }
    
    func makeCustomer(from row: Row) -> Customer {
        let customer = Customer(username: row[UsersTable.username], password: row[UsersTable.password])
        row[UsersTable.isBlocked] ? customer.block() : ()
        
        let bookings = getBookings(forCustomerId: row[UsersTable.id])
        bookings.forEach { customer.addBooking($0) }
        
        return customer
    }
    
    func makeAdmin(from row: Row) -> Admin {
        let admin = Admin(username: row[UsersTable.username], password: row[UsersTable.password])
        row[UsersTable.isBlocked] ? admin.block() : ()
        
        let privileges = getPrivileges(forAdminId: row[UsersTable.id])
        privileges.forEach { admin.grant($0) }
        
        return admin
    }
    
    func getPrivileges(forAdminId adminId: Int) -> [Admin.Privilege] {
        do {
            return try db.prepare(AdminPrivilegesTable.table.filter(AdminPrivilegesTable.adminId == adminId))
                .map { AdminPrivilegeMapper.toEnumCase($0[AdminPrivilegesTable.privilege]) }
        } catch {
            return []
        }
    }
    
    func getBookings(forCustomerId customerId: Int) -> [Booking] {
        
    }
}
