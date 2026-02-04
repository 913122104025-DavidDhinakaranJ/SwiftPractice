import Errors
import Models

public protocol ManageMovieController {
    func getAllMovies() -> [Movie]
    func add(movie: Movie) throws(RepoError)
    func update(movie: Movie) throws(RepoError)
    func remove(movie: Movie) throws(RepoError)
}
