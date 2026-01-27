import Models

public protocol ShowRepository {
    func save(show: Show)
    func delete(show: Show)
    
    func getAll() -> [Show]
    func getFutureShows(forMovie movie: Movie) -> [Show]
    
    func isShowConflict(_ show: Show) -> Bool
}
