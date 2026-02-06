import SQLite
import Foundation

enum ShowsTable {
    static let table = Table("shows")
    
    static let id = Expression<Int64>("id")
    static let movieId = Expression<Int64>("movie_id")
    static let cinemaHallId = Expression<Int64>("cinema_hall_id")
    static let startTime = Expression<Date>("start_time")
    static let endTime = Expression<Date>("end_time")
    static let price = Expression<Double>("price")
}
