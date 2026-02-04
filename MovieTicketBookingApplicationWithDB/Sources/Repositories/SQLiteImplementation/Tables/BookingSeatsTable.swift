import SQLite

enum BookingSeatsTable {
    static let table = Table("bookings_seats")
    
    static let bookingId = Expression<Int>("booking_id")
    static let showSeatId = Expression<Int>("show_seat_id")
}
