import Models
import AuthLib

public final class InMemoryRepository: UserRepository, MovieRepository, TheatreRepository, ShowRepository {
    nonisolated(unsafe) private static var shared: InMemoryRepository = .init()
    
    private final var users: [String: User] = [:]
    private final var movies: [String: Movie] = [:]
    private final var theatres: [String: Theatre] = [:]
    private final var shows: [String: Show] = [:]
    
    private init() {}
    
    public static func getInMemoryRepository() -> InMemoryRepository { shared }
    
    public func getAll(role: User.Role) -> [User] {
        var result: [User] = []
        
        for user in users.values where user.role == role {
            result.append(user)
        }
        
        return result
    }
    
    public func save(user: any AuthenticatableUser) {
        users.updateValue(user as! User, forKey: user.username)
    }
    
    public func find(user: String) -> (any AuthenticatableUser)? {
        users[user]
    }
    
    public func isUser(withName username: String) -> Bool {
        users[username] != nil
    }
    
    public func save(movie: Movie) {
        movies.updateValue(movie, forKey: movie.movieId)
    }
    
    public func delete(movie: Movie) {
        movies.removeValue(forKey: movie.movieId)
    }
    
    public func isMovieExists(withTitle title: String) -> Bool {
        movies.contains(where: { $0.value.title == title })
    }
    
    public func getAllMovies() -> [Movie] {
        movies.values.sorted { $0.title < $1.title }
    }
    
    public func getMovies(title: String) -> [Movie] {
        movies.values.filter { $0.title.contains(title) }
    }
    
    public func getMovies(genre: Movie.Genre) -> [Movie] {
        movies.values.filter { $0.genres.contains(genre) }
    }
    
    public func getMovies(language: Movie.Language) -> [Movie] {
        movies.values.filter { $0.languages.contains(language) }
    }
    
    public func getMovies(rating: Movie.Rating) -> [Movie] {
        movies.values.filter { $0.rating == rating }
    }
    
    public func save(theatre: Theatre) {
        theatres.updateValue(theatre, forKey: theatre.theatreId)
    }
    
    public func remove(theatre: Theatre) {
        theatres.removeValue(forKey: theatre.theatreId)
    }
    
    public func getAll() -> [Theatre] {
        theatres.values.sorted { $0.name < $1.name }
    }
    
    public func save(show: Show) {
        shows.updateValue(show, forKey: show.showId)
    }
    
    public func delete(show: Show) {
        shows.removeValue(forKey: show.showId)
    }
    
    public func getAll() -> [Show] {
        shows.values.sorted { $0.startTime < $1.startTime }
    }
    
    public func getFutureShows(forMovie movie: Movie) -> [Show] {
        shows.values.filter{ $0.movie.movieId == movie.movieId }.sorted { $0.startTime < $1.startTime }
    }
    
    public func isShowConflict(_ show: Show) -> Bool {
        shows.values.contains {
            $0.showId != show.showId &&
            $0.theatre.theatreId == show.theatre.theatreId &&
            $0.cinemaHall.hallId == show.cinemaHall.hallId &&
            $0.startTime < show.endTime &&
            show.startTime < $0.endTime
        }
    }
}
