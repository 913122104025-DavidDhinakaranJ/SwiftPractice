import Models

public protocol SearchController {
    func getMovies(withTitle: String) -> [Movie]
    func getMovies(withGenre: Movie.Genre) -> [Movie]
    func getMovies(withLanguage: Movie.Language) -> [Movie]
    func getMovies(withRating: Movie.Rating) -> [Movie]
}
