import SQLite

enum MovieLanguagesTable {
    static let table = Table("movie_languages")
    
    static let movieId = Expression<Int>("movie_id")
    static let language = Expression<String>("language")
}
