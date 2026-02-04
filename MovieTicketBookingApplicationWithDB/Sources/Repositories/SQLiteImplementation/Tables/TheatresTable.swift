import SQLite

enum TheatresTable {
    static let table = Table("theatres")
    
    static let id = Expression<Int>("id")
    static let theatreName = Expression<String>("name")
    static let address = Expression<String>("address")
}
