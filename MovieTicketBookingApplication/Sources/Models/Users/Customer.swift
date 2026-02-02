public final class Customer: User {
    public private(set) var bookings: [Booking] = []
    
    public init(username: String, password: String) {
        super.init(username: username, password: password, role: .customer)
    }
    
    public func addBooking(_ booking: Booking) {
        bookings.append(booking)
    }
}
