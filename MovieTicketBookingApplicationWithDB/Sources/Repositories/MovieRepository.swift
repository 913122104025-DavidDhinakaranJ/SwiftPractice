import Errors
import Models

public protocol MovieRepository {
    func add(movie: Movie) throws(RepoError)
    func update(movie: Movie) throws(RepoError)
    func delete(movie: Movie) throws(RepoError)
    
    func isMovieExists(withTitle title: String) -> Bool
    
    func getAll() -> [Movie]
    func getMovies(where matcher: (Movie) -> Bool) -> [Movie]
}
