import AuthLib
import Errors
import Models

public final class InMemoryRepository: UserRepository, MovieRepository, TheatreRepository, ShowRepository {
    nonisolated(unsafe) public private(set) static var shared: InMemoryRepository = .init()
    
    private final var users: [String: User] = [:]
    private final var movies: [String: Movie] = [:]
    private final var theatres: [String: Theatre] = [:]
    private final var shows: [String: Show] = [:]
    
    private init() {}
    
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
    
    public func add(movie: Movie) throws(RepoError) {
        guard !movies.keys.contains(movie.title) else {
            throw RepoError.alreadyExists
        }
        movies.updateValue(movie, forKey: movie.title)
    }
    
    public func update(movie: Movie) throws(RepoError) {
        guard movies.keys.contains(movie.title) else {
            throw RepoError.notFound
        }
        
        movies.updateValue(movie, forKey: movie.title)
    }
    
    public func delete(movie: Movie) throws(RepoError) {
        guard movies.keys.contains(movie.title) else {
            throw RepoError.notFound
        }
        movies.removeValue(forKey: movie.title)
    }
    
    public func isMovieExists(withTitle title: String) -> Bool {
        movies.contains(where: { $0.value.title == title })
    }
    
    public func getAll() -> [Movie] {
        movies.values.sorted { $0.title < $1.title }
    }
    
    public func getMovies(where matcher: (Movie) -> Bool) -> [Movie] {
        movies.values.filter(matcher)
    }
    
    public func add(theatre: Theatre) throws(RepoError) {
        guard !theatres.keys.contains(theatre.name) else {
            throw RepoError.alreadyExists
        }
        
        theatres.updateValue(theatre, forKey: theatre.name)
    }
    
    public func update(theatre: Theatre) throws(RepoError) {
        guard theatres.keys.contains(theatre.name) else {
            throw RepoError.notFound
        }
        
        theatres.updateValue(theatre, forKey: theatre.name)
    }
    
    public func remove(theatre: Theatre) throws(RepoError) {
        guard theatres.keys.contains(theatre.name) else {
            throw RepoError.notFound
        }
        
        theatres.removeValue(forKey: theatre.name)
    }
    
    public func getAll() -> [Theatre] {
        theatres.values.sorted { $0.name < $1.name }
    }
    
    public func add(show: Show) throws(RepoError) {
        if isShowConflict(show) {
            throw RepoError.alreadyExists
        }
        
        shows.updateValue(show, forKey: show.showId)
    }
    
    public func update(show: Show) throws(RepoError) {
        guard shows.keys.contains(show.showId) else {
            throw RepoError.notFound
        }
        
        shows.updateValue(show, forKey: show.showId)
    }
    
    public func delete(show: Show) throws(RepoError) {
        guard shows.keys.contains(show.showId) else {
            throw RepoError.notFound
        }
        
        shows.removeValue(forKey: show.showId)
    }
    
    public func getAll() -> [Show] {
        shows.values.sorted { $0.startTime < $1.startTime }
    }
    
    public func getFutureShows(forMovie movie: Movie) -> [Show] {
        shows.values.filter { $0.movie.title == movie.title }.sorted { $0.startTime < $1.startTime }
    }
    
    private func isShowConflict(_ show: Show) -> Bool {
        shows.values.contains {
            $0.showId != show.showId &&
            $0.theatre.name == show.theatre.name &&
            $0.cinemaHall.name == show.cinemaHall.name &&
            $0.startTime < show.endTime &&
            show.startTime < $0.endTime
        }
    }
}
