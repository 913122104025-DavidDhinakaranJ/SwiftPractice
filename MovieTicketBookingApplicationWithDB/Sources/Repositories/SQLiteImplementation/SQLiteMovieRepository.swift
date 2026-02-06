import SQLite
import Models
import Errors

extension SQLiteRepository: MovieRepository {
    public func add(movie: Movie) throws(RepoError) {
        guard movie.id == nil else { throw RepoError.alreadyExists }
        
        do {
            try db.transaction {
                let insertMovie = MoviesTable.table.insert(
                    MoviesTable.title <- movie.title,
                    MoviesTable.releaseDate <- movie.releaseDate,
                    MoviesTable.duration <- movie.durationInMinutes,
                    MoviesTable.rating <- MovieRatingMapper.toString(movie.rating)
                )
                
                let movieId = try db.run(insertMovie)
                
                try saveGenres(genres: movie.genres, movieId: movieId)
                try saveLanguages(languages: movie.languages, movieId: movieId)
            }
                
        } catch let error as SQLite.Result {
            switch error {
            case .error(_, let code, _):
                if code == ErrorCode.SQLITE_CONSTRAINT_UNIQUE {
                    throw RepoError.alreadyExists
                }
                throw RepoError.dbFailure
            default:
                throw RepoError.dbFailure
            }
        }
        catch {
            throw RepoError.dbFailure
        }
    }
    
    public func update(movie: Movie) throws(RepoError) {
        guard let movieId = movie.id else { throw RepoError.notFound }
        
        do {
            try db.transaction {
                let updateMovie = MoviesTable.table.filter(MoviesTable.id == movieId).update(
                    MoviesTable.title <- movie.title,
                    MoviesTable.releaseDate <- movie.releaseDate,
                    MoviesTable.duration <- movie.durationInMinutes,
                    MoviesTable.rating <- MovieRatingMapper.toString(movie.rating)
                )
                
                let rowsUpdated = try db.run(updateMovie)
                if rowsUpdated == 0 { throw RepoError.notFound }
                
                try saveGenres(genres: movie.genres, movieId: movieId)
                try saveLanguages(languages: movie.languages, movieId: movieId)
            }
        } catch let error as RepoError {
            throw error
        } catch {
            throw RepoError.dbFailure
        }
    }
    
    public func delete(movie: Movie) throws(RepoError) {
        guard let movieId = movie.id else { throw RepoError.notFound }
        
        do {
            try db.transaction {
                let deleteMovie = MoviesTable.table.filter(MoviesTable.id == movieId).delete()
                let rowsDeleted = try db.run(deleteMovie)
                if rowsDeleted == 0 { throw RepoError.notFound }
            }
        } catch let error as RepoError {
            throw error
        } catch {
            throw RepoError.dbFailure
        }
    }
    
    public func getAll() -> [Movie] {
        return try! db.prepare(MoviesTable.table).map(makeMovie)
    }
    
    public func getMovies(where matcher: (Movie) -> Bool) -> [Movie] {
        return try! db.prepare(MoviesTable.table).map(makeMovie).filter(matcher)
    }
    
    private func saveGenres(genres: Set<Movie.Genre>, movieId: Int64) throws {
        let oldGenres = MovieGenresTable.table.filter(MovieGenresTable.movieId == movieId)
        try db.run(oldGenres.delete())
        
        for genre in genres {
            let insertGenre = MovieGenresTable.table.insert(
                MovieGenresTable.movieId <- movieId,
                MovieGenresTable.genre <- MovieGenreMapper.toString(genre)
            )
            
            try db.run(insertGenre)
        }
    }
    
    private func saveLanguages(languages: Set<Movie.Language>, movieId: Int64) throws {
        let oldLanguages = MovieLanguagesTable.table.filter(MovieLanguagesTable.movieId == movieId)
        try db.run(oldLanguages.delete())
        
        for language in languages {
            let insertLanguage = MovieLanguagesTable.table.insert(
                MovieLanguagesTable.movieId <- movieId,
                MovieLanguagesTable.language <- MovieLanguageMapper.toString(language)
            )
            
            try db.run(insertLanguage)
        }
    }
}
