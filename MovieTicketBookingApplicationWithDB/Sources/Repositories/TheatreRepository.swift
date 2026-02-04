import Errors
import Models

public protocol TheatreRepository {
    func add(theatre: Theatre) throws(RepoError)
    func update(theatre: Theatre) throws(RepoError)
    func remove(theatre: Theatre) throws(RepoError)
    
    func getAll() -> [Theatre]
}
