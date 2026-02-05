import SQLite
import Models
import Errors

extension SQLiteRepository: MovieRepository {
    public func add(movie: Movie) throws(RepoError) {
        <#code#>
    }
    
    public func update(movie: Movie) throws(RepoError) {
        <#code#>
    }
    
    public func delete(movie: Movie) throws(RepoError) {
        <#code#>
    }
    
    public func isMovieExists(withTitle title: String) -> Bool {
        do {
            return try db.pluck(MoviesTable.table.filter(MoviesTable.name == title)) != nil
        } catch {
            fatalError("Error in DB")
        }
    }
    
    public func getAll() -> [Movie] {
        do {
            return try db.prepare(ShowsTable.table).map(makeMovie)
        } catch {
            fatalError("Error in DB")
        }
    }
    
    public func getMovies(where matcher: (Movie) -> Bool) -> [Movie] {
        do {
            return try db.prepare(ShowsTable.table).map(makeMovie).filter(matcher)
        } catch {
            fatalError("Error in DB")
        }
    }
}
