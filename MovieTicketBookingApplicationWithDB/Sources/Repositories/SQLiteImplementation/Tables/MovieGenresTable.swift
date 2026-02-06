import SQLite

enum MovieGenresTable {
    static let table = Table("movie_genres")
    
    static let movieId = Expression<Int64>("movie_id")
    static let genre = Expression<String>("genre")
}
