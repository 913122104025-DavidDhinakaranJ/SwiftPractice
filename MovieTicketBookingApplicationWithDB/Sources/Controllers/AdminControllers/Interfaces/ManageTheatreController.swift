import Errors
import Models

public protocol ManageTheatreController {
    func getAllTheatres() -> [Theatre]
    
    func addTheatre(_ theatre: Theatre) throws(RepoError)
    func updateTheatre(_ theatre: Theatre) throws(RepoError)
    func deleteTheatre(_ theatre: Theatre) throws(RepoError)
}
