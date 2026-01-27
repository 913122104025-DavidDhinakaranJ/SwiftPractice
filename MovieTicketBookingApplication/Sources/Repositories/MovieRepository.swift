import Models

public protocol MovieRepository {
    func save(movie: Movie)
    func delete(movie: Movie)
    
    func isMovieExists(withTitle title: String) -> Bool
    
    func getAllMovies() -> [Movie]
    func getMovies(title: String) -> [Movie]
    func getMovies(genre: Movie.Genre) -> [Movie]
    func getMovies(language: Movie.Language) -> [Movie]
    func getMovies(rating: Movie.Rating) -> [Movie]
}
