import Errors
import Models

public protocol ShowRepository {
    func add(show: Show) throws(RepoError)
    func update(show: Show) throws(RepoError)
    func delete(show: Show) throws(RepoError)
    
    func getAll() -> [Show]
    func getFutureShows(forMovie movie: Movie) -> [Show]
}
