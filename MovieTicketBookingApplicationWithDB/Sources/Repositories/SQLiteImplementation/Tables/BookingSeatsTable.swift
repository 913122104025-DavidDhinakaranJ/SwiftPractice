import SQLite

enum BookingSeatsTable {
    static let table = Table("bookings_seats")
    
    static let bookingId = Expression<Int64>("booking_id")
    static let showSeatId = Expression<Int64>("show_seat_id")
}
