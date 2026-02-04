import SQLite
import Foundation

enum BookingsTable {
    static let table = Table("bookings")
    
    static let id = Expression<Int>("id")
    static let customerId = Expression<Int>("customer_id")
    static let bookingDate = Expression<Date>("booking_date")
    static let status = Expression<String>("status")
    static let showId = Expression<Int>("show_id")
    static let totalPrice = Expression<Double>("total_price")
    static let paymentId = Expression<Int>("payment_id")
}
