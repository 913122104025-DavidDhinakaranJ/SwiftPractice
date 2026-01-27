import Foundation

public final class Booking {
    private enum Status {
        case pending, confirmed, cancelled
    }
    
    nonisolated(unsafe) private static var idCounter: Int = 0
    
    public let bookingId: String
    public let bookingDate: Date
    private var status: Status = .pending
    public unowned let customer: Customer
    public let show: Show
    public let seats: [ShowSeat]
    public let totalPrice: Double
    public let payment: Payment
    
    public var isConfirmed: Bool { self.status == .confirmed }
    public var isCancelled: Bool { self.status == .cancelled }
    
    public init(customer: Customer, show: Show, seats: [ShowSeat]) {
        Booking.idCounter += 1
        self.bookingId = "B\(Booking.idCounter)"
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
        self.status = .confirmed
        seats.forEach { showSeat in
            showSeat.book()
        }
    }
    
    public func cancel() {
        self.status = .cancelled
        seats.forEach { showSeat in
            showSeat.unbook()
        }
    }
}
