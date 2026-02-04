import Models

public protocol MovieController {
    func getShows(for movie: Movie) -> [Show]
}
