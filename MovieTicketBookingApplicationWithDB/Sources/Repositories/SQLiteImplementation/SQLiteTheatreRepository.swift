import SQLite
import Models
import Errors

extension SQLiteRepository: TheatreRepository {
    public func add(theatre: Theatre) throws(RepoError) {
        <#code#>
    }
    
    public func update(theatre: Theatre) throws(RepoError) {
        <#code#>
    }
    
    public func remove(theatre: Theatre) throws(RepoError) {
        <#code#>
    }
    
    public func getAll() -> [Theatre] {
        <#code#>
    }
}
