import AuthLib
import Models
import SQLite

extension SQLiteRepository: UserRepository {
    public func getAll(role: User.Role) -> [User] {
        return try! db.prepare(UsersTable.table.filter(UsersTable.role == UserRoleMapper.toString(role))).map(makeUser)
    }
    
    public func save(user: any AuthenticatableUser) {
        guard let user = user as? User else { return }
        
        do {
            try db.transaction {
                let userId: Int64
                if let id = user.id {
                    let updateUser = UsersTable.table.filter(UsersTable.id == id).update(
                        UsersTable.username <- user.username,
                        UsersTable.password <- user.passwordHashForStorage,
                        UsersTable.role <- UserRoleMapper.toString(user.role),
                        UsersTable.isBlocked <- user.isBlocked
                    )
                    
                    try self.db.run(updateUser)
                    userId = id
                    
                } else {
                    let insertUser = UsersTable.table.insert(
                        UsersTable.username <- user.username,
                        UsersTable.password <- user.passwordHashForStorage,
                        UsersTable.role <- UserRoleMapper.toString(user.role),
                        UsersTable.isBlocked <- user.isBlocked
                    )
                    userId = try self.db.run(insertUser)
                    user.setId(userId)
                }
                
                if let admin = user as? Admin {
                    try self.saveAdminPrivileges(admin.privileges, userId: userId)
                }
                else if let customer = user as? Customer {
                    try self.saveCustomerBookings(customer.bookings, userId: userId)
                }
            }
        } catch {
            fatalError("Error in DB \(error)")
        }
    }
    
    public func find(user: String) -> (any AuthenticatableUser)? {
        return try! db.pluck(UsersTable.table.filter(UsersTable.username == user)).map(makeUser)
    }
    
    public func isUserexists(withName username: String) -> Bool {
        return find(user: username) != nil
    }
    
    private func saveAdminPrivileges(_ privileges: Set<Admin.Privilege>, userId: Int64) throws {
        let deleteOldPrivileges = AdminPrivilegesTable.table.filter(AdminPrivilegesTable.adminId == userId).delete()
        try db.run(deleteOldPrivileges)
        
        for privilege in privileges {
            let insertPrivilege = AdminPrivilegesTable.table.insert(
                AdminPrivilegesTable.adminId <- userId,
                AdminPrivilegesTable.privilege <- AdminPrivilegeMapper.toString(privilege)
            )
            try db.run(insertPrivilege)
        }
    }
    
    private func saveCustomerBookings(_ bookings: [Booking], userId: Int64) throws {
        for booking in bookings {
            let bookingId: Int64
            if let id = booking.id {
                bookingId = id
                let update = BookingsTable.table.filter(BookingsTable.id == id).update(
                    BookingsTable.customerId <- userId,
                    BookingsTable.bookingDate <- booking.bookingDate,
                    BookingsTable.status <- BookingStatusMapper.toString(booking.status),
                    BookingsTable.showId <- booking.show.id!,
                    BookingsTable.totalPrice <- booking.totalPrice,
                    BookingsTable.paymentId <- booking.payment.id!
                )
                
                try db.run(update)
            } else {
                let paymentId = try savePayment(booking.payment)
                
                let insert = BookingsTable.table.insert(
                    BookingsTable.customerId <- userId,
                    BookingsTable.bookingDate <- booking.bookingDate,
                    BookingsTable.status <- BookingStatusMapper.toString(booking.status),
                    BookingsTable.showId <- booking.show.id!,
                    BookingsTable.totalPrice <- booking.totalPrice,
                    BookingsTable.paymentId <- paymentId
                )
                
                bookingId = try db.run(insert)
            }
            
            try updateShowSeatAvailability(showSeats: booking.seats, bookingId: bookingId)
        }
    }
    
    private func savePayment(_ payment: Payment) throws -> Int64 {
        let insert = PaymentsTable.table.insert(or: .ignore,
            PaymentsTable.amount <- payment.amount,
            PaymentsTable.status <- PaymentStatusMapper.toString(payment.status),
            PaymentsTable.paymentDate <- payment.paymentDate
        )
        
        let paymentId = try db.run(insert)
        return paymentId
    }
    
    private func updateShowSeatAvailability(showSeats: [ShowSeat], bookingId: Int64) throws {
        for showSeat in showSeats {
            let update = ShowSeatsTable.table.filter(ShowSeatsTable.id == showSeat.id!).update(
                ShowSeatsTable.status <- ShowSeatStatusMapper.toString(showSeat.status),
            )
            
            try db.run(update)
            
            let insert = BookingSeatsTable.table.insert(or: .ignore,
                BookingSeatsTable.bookingId <- bookingId,
                BookingSeatsTable.showSeatId <- showSeat.id!
            )
            try db.run(insert)
        }
    }
}
