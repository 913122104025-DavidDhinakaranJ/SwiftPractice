public final class Customer: User {
    public private(set) var bookings: [Booking] = []
    
    public init(username: String, password: String) {
        super.init(username: username, password: password, role: .customer)
    }
    
    private init(id: Int64, username: String, passwordHash: String, isBlocked: Bool) {
        super.init(id: id, username: username, passwordHash: passwordHash, role: .customer, isBlocked: isBlocked)
    }
    
    public static func rehydrate(id: Int64, username: String, passwordHash: String, isBlocked: Bool) -> Customer {
        .init(id: id, username: username, passwordHash: passwordHash, isBlocked: isBlocked)
    }
    
    public func attach(bookings: [Booking]) {
        self.bookings = bookings
    }
    
    public func addBooking(_ booking: Booking) {
        bookings.append(booking)
    }
}
