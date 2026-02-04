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
        <#code#>
    }
    
    public func getAll() -> [Movie] {
        <#code#>
    }
    
    public func getMovies(where matcher: (Movie) -> Bool) -> [Movie] {
        <#code#>
    }
}
