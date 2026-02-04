import SQLite

enum ShowSeatsTable {
    static let table = Table("show_seats")
    
    static let id = Expression<Int>("id")
    static let seatId = Expression<Int>("seat_id")
    static let showId = Expression<Int>("show_id")
    static let status = Expression<String>("status")
}
