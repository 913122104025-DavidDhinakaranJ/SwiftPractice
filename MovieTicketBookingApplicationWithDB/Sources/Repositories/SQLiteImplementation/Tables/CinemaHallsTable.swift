import SQLite

enum CinemaHallsTable {
    static let table = Table("cinema_halls")
    
    static let id = Expression<Int64>("id")
    static let cinemaHallName = Expression<String>("name")
    static let theatreId = Expression<Int64>("theatre_id")
}
