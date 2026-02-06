import Foundation
import Errors

public final class Booking {
    public enum Status {
        case pending, confirmed, cancelled
    }
        
    public let id: Int64?
    public let bookingDate: Date
    public private(set) var status: Status = .pending
    public unowned let customer: Customer
    public let show: Show
    public let seats: [ShowSeat]
    public let totalPrice: Double
    public let payment: Payment
    
    public init(customer: Customer, show: Show, seats: [ShowSeat]) throws(BookingError) {
        guard !customer.isBlocked else { throw BookingError.blockedCustomer }
        
        self.id = nil
        self.bookingDate = Date()
        self.customer = customer
        self.show = show
        self.seats = seats
        self.payment = Payment()
        self.totalPrice = seats.reduce(0) { $0 + show.price * $1.seat.type.rawValue }
    }
    
    private init(id: Int64, bookingDate: Date, status: Status, customer: Customer, show: Show, seats: [ShowSeat], totalPrice: Double, payment: Payment) {
        self.id = id
        self.bookingDate = bookingDate
        self.customer = customer
        self.show = show
        self.seats = seats
        self.payment = payment
        self.totalPrice = totalPrice
    }
    
    public static func rehydrate(id: Int64, bookingDate: Date, status: Status, customer: Customer, show: Show, seats: [ShowSeat], totalPrice: Double, payment: Payment) -> Booking {
        .init(id: id, bookingDate: bookingDate, status: status, customer: customer, show: show, seats: seats, totalPrice: totalPrice, payment: payment)
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
        payment.updateStatusToRefunded()
    }
}
