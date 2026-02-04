import SQLite
import Foundation

enum MoviesTable {
    static let table = Table("movies")
    
    static let id = Expression<Int>("id")
    static let name = Expression<String>("name")
    static let duration = Expression<Int>("duration")
    static let rating = Expression<String>("rating")
    static let releaseDate = Expression<Date>("release_date")
}
