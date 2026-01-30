import Errors
import Models

public protocol ManageShowController {
    func getAllShows() -> [Show]
    func getAllMovies() -> [Movie]
    func getAllTheatres() -> [Theatre]
    
    func addShow(show: Show) throws(RepoError)
    func updateShow(show: Show) throws(RepoError)
    func removeShow(show: Show) throws(RepoError)
}
