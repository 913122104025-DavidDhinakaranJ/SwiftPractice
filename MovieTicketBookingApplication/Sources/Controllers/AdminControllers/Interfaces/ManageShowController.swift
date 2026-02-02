import Errors
import Models

public protocol ManageShowController {
    func getAllShows() -> [Show]
    func getAllMovies() -> [Movie]
    func getAllTheatres() -> [Theatre]
    
    func addShow(_ show: Show)throws(RepoError)
    func updateShow(_ show: Show) throws(RepoError)
    func removeShow(_ show: Show) throws(RepoError)
}
