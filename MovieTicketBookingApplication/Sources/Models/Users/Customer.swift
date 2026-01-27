public final class Customer: User {
    nonisolated(unsafe) private static var idCounter: Int = 1000
    public private(set) var bookings: [Booking] = []
    
    public init(username: String, password: String) {
        Self.idCounter += 1
        super.init(userId: "C\(Self.idCounter)", username: username, password: password, role: .customer)
    }
    
    public func addBooking(_ booking: Booking) {
        bookings.append(booking)
    }
}
