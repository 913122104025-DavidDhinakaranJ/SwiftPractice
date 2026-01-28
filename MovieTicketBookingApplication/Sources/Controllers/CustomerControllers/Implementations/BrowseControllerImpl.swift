import Models
import Repositories

public struct BrowseControllerImpl: BrowseController {
    public enum SearchCriteria {
        case all
        case title(String)
        case genre(Movie.Genre)
        case language(Movie.Language)
        case rating(Movie.Rating)
    }
    
    private let movieRepository: MovieRepository
    private let criteria: SearchCriteria
    
    public init(movieRepository: MovieRepository, criteria: SearchCriteria) {
        self.movieRepository = movieRepository
        self.criteria = criteria
    }
    
    public func getMovies() -> [Movie] {
        return switch criteria {
        case .all: movieRepository.getAllMovies()
        case .title(let title): movieRepository.getMovies(title: title)
        case .genre(let genre): movieRepository.getMovies(genre: genre)
        case .language(let Language): movieRepository.getMovies(language: Language)
        case .rating(let rating): movieRepository.getMovies(rating: rating)
        }
    }
}
