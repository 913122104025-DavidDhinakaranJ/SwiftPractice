import Foundation

public final class Booking {
    public enum Status {
        case pending, confirmed, cancelled
    }
        
    public let bookingId: String
    public let bookingDate: Date
    public private(set) var status: Status = .pending
    public unowned let customer: Customer
    public let show: Show
    public let seats: [ShowSeat]
    public let totalPrice: Double
    public let payment: Payment
    
    public init(customer: Customer, show: Show, seats: [ShowSeat]) {
        self.bookingId = "BOOKING-\(UUID().uuidString)"
        self.bookingDate = Date()
        self.customer = customer
        self.show = show
        self.seats = seats
        self.payment = Payment()
        
        let basePrice = show.price
        var totalPrice = 0.0
        seats.forEach { showSeat in
            totalPrice += basePrice * showSeat.seat.type.rawValue
        }
        self.totalPrice = totalPrice
    }
    
    public func confirm() {
        guard status == .pending else { return }
        self.status = .confirmed
        customer.addBooking(self)
        seats.forEach { showSeat in
            showSeat.book()
        }
    }
    
    public func cancel() {
        guard status == .confirmed else { return }
        self.status = .cancelled
        seats.forEach { showSeat in
            showSeat.unbook()
        }
    }
}
