import Errors
import Repositories
import Models

public struct ManageShowControllerImpl: ManageShowController {
    private let showRepository: ShowRepository
    private let movieRepository: MovieRepository
    private let theatreRepository: TheatreRepository
    
    public init(showRepository: ShowRepository, theatreRepository: TheatreRepository, movieRepository: MovieRepository) {
        self.showRepository = showRepository
        self.theatreRepository = theatreRepository
        self.movieRepository = movieRepository
    }
    
    public func getAllShows() -> [Show] {
        showRepository.getAll()
    }
    
    public func getAllMovies() -> [Movie] {
        movieRepository.getAll()
    }
    
    public func getAllTheatres() -> [Theatre] {
        theatreRepository.getAll()
    }
    
    public func addShow(_ show: Show) throws(RepoError) {
        try showRepository.add(show: show)
    }
    
    public func updateShow(_ show: Show) throws(RepoError) {
        try showRepository.update(show: show)
    }
    
    public func removeShow(_ show: Show) throws(RepoError) {
        try showRepository.delete(show: show)
    }
}
