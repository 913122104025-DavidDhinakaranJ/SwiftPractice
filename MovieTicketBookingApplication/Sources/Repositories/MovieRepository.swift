import Errors
import Models

public protocol MovieRepository {
    func add(movie: Movie) throws(RepoError)
    func update(movie: Movie) throws(RepoError)
    func delete(movie: Movie) throws(RepoError)
    
    func isMovieExists(withTitle title: String) -> Bool
    
    func getAll() -> [Movie]
    func getMovies(title: String) -> [Movie]
    func getMovies(genre: Movie.Genre) -> [Movie]
    func getMovies(language: Movie.Language) -> [Movie]
    func getMovies(rating: Movie.Rating) -> [Movie]
}
