import SQLite
import Models
import Errors
import Foundation

extension SQLiteRepository: ShowRepository {
    public func add(show: Show) throws(RepoError) {
        <#code#>
    }
    
    public func update(show: Show) throws(RepoError) {
        <#code#>
    }
    
    public func delete(show: Show) throws(RepoError) {
        <#code#>
    }
    
    public func getAll() -> [Show] {
        do {
            return try db.prepare(ShowsTable.table).map(makeShow)
        } catch {
            fatalError("Error in DB")
        }
    }
    
    public func getFutureShows(forMovie movie: Movie) -> [Show] {
        do {
            return try db.prepare(ShowsTable.table.filter(ShowsTable.startTime > Date())).map(makeShow)
        } catch {
            fatalError("Error in DB")
        }
    }
}
