import SQLite

enum MovieGenresTable {
    static let table = Table("movie_genres")
    
    static let movieId = Expression<Int>("movie_id")
    static let genre = Expression<String>("genre")
}
