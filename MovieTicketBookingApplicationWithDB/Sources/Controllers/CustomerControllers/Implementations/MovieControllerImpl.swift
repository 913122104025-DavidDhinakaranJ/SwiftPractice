import Models
import Repositories

public struct MovieControllerImpl: MovieController {
    private let showRepository: ShowRepository
    
    public init(showRepository: ShowRepository) {
        self.showRepository = showRepository
    }
    
    public func getShows(for movie: Movie) -> [Show] {
        showRepository.getFutureShows(forMovie: movie)
    }
}
