import Errors
import Models

public protocol MovieRepository {
    func add(movie: Movie) throws(RepoError)
    func update(movie: Movie) throws(RepoError)
    func delete(movie: Movie) throws(RepoError)
        
    func getAll() -> [Movie]
    func getMovies(where matcher: (Movie) -> Bool) -> [Movie]
}
