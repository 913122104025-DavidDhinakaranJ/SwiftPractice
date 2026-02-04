import SQLite
import Models
import Errors

extension SQLiteRepository: ShowRepository {
    public func add(show: Show) throws(RepoError) {

    }
    
    public func update(show: Show) throws(RepoError) {
        <#code#>
    }
    
    public func delete(show: Show) throws(RepoError) {
        <#code#>
    }
    
    public func getAll() -> [Show] {
        <#code#>
    }
    
    public func getFutureShows(forMovie movie: Movie) -> [Show] {
        <#code#>
    }
}
