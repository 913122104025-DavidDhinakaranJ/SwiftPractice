import Errors
import Models
import Repositories

public struct ManageMovieControllerImpl: ManageMovieController {
    private let movieRepository: MovieRepository
    
    public init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    public func getAllMovies() -> [Movie] {
        movieRepository.getAll()
    }
    
    public func add(movie: Models.Movie) throws(Errors.RepoError) {
        try movieRepository.add(movie: movie)
    }
    
    public func update(movie: Models.Movie) throws(Errors.RepoError) {
        try movieRepository.update(movie: movie)
    }
    
    public func remove(movie: Models.Movie) throws(Errors.RepoError) {
        try movieRepository.delete(movie: movie)
    }
}
