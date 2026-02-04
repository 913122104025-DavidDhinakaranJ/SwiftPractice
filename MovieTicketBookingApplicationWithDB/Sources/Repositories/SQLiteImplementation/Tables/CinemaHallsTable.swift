import SQLite

enum CinemaHallsTable {
    static let table = Table("cinema_halls")
    
    static let id = Expression<Int>("id")
    static let cinemaHallName = Expression<String>("name")
    static let theatreId = Expression<Int>("theatre_id")
}
