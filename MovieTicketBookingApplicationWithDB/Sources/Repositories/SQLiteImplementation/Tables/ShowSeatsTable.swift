import SQLite

enum ShowSeatsTable {
    static let table = Table("show_seats")
    
    static let id = Expression<Int64>("id")
    static let seatId = Expression<Int64>("seat_id")
    static let showId = Expression<Int64>("show_id")
    static let status = Expression<String>("status")
}
