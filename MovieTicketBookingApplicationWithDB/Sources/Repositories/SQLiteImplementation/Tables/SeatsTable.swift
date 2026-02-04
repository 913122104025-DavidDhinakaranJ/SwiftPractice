import SQLite

enum SeatsTable {
    static let table = Table("seats")
    
    static let id = Expression<Int>("id")
    static let row = Expression<String>("row")
    static let seatNumber = Expression<Int>("seat_number")
    static let type = Expression<String>("type")
    static let cinemaHallId = Expression<Int>("cinema_hall_id")
}
