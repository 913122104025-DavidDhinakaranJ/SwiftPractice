import Controllers
import Errors
import Models
import Utils

struct ConsoleManageMovieView {
    private enum MovieManageOption: String, CaseIterable, CustomStringConvertible {
        case addMovie = "Add Movie"
        case viewMovies = "View Movies"
        case updateMovie = "Update Movie"
        case deleteMovie = "Delete Movie"
        case exit = "Exit"
        
        var description: String { rawValue }
    }
    
    private enum UpdateMovieOption: String, CaseIterable, CustomStringConvertible {
        case updateGenres = "Update Genres"
        case updateLanguages = "Update Languages"
        case updateDuration = "Update Duration"
        case updateReleaseDate = "Update Release Date"
        case back = "Back"
        
        var description: String { rawValue }
    }
    
    private let inputReader = ConsoleInputUtil()
    private let manageMovieController: ManageMovieController
    
    private var running = false
    
    init(manageMovieController: ManageMovieController) {
        self.manageMovieController = manageMovieController
    }
    
    mutating func runView() {
        running = true
        while running {
            let options: [MovieManageOption] = [.addMovie, .viewMovies, .exit]
            let selectedOption = inputReader.readMenuOption(options)
            
            switch selectedOption {
            case .addMovie: handleAddMovie()
            case .viewMovies: handleViewMovies()
            case .exit: handleExit()
            default: fatalError("Unhandled case")
            }
        }
    }
    
    private func handleAddMovie() {
        let title = inputReader.readString(prompt: "Enter movie title")
        let genres = inputReader.readMultipleChoices(mainPrompt: "Select genres for the movie", Movie.Genre.allCases)
        let languages = inputReader.readMultipleChoices(mainPrompt: "Select languages for the movie", Movie.Language.allCases)
        let rating = inputReader.readChoice(prompt: "Enter Rating Choice: ", Movie.Rating.allCases)
        let duration = inputReader.readPositiveInt(prompt: "Enter movie duration in minutes")
        let releaseDate = inputReader.readDate(prompt: "Enter release date (yyyy-MM-dd)")
        
        var movie = Movie(title: title, durationInMinutes: duration, rating: rating, releaseDate: releaseDate)
        genres.forEach { movie.addGenre($0) }
        languages.forEach { movie.addLanguage($0) }
        
        do {
            try manageMovieController.add(movie: movie)
        } catch RepoError.alreadyExists {
            print("A movie with the title '\(title)' already exists.")
        } catch {
            fatalError("unexpected error: \(error)")
        }
    }
    
    private func handleViewMovies() {
        let options: [MovieManageOption] = [.updateMovie, .deleteMovie, .exit]
        var selectedMovie = inputReader.readChoiceWithExit(manageMovieController.getAllMovies()) { movie in movie.title }
        
        while let currentMovie = selectedMovie {
            displayMovieDetails(currentMovie)
            let selectedSubOption = inputReader.readMenuOption(options)
            
            selectedMovie = switch selectedSubOption {
            case .updateMovie: handleUpdateMovie(currentMovie)
            case .deleteMovie: handleDeleteMovie(currentMovie)
            case .exit: nil
            default: fatalError("Unhandled case")
            }
        }
    }
    
    private func displayMovieDetails(_ movie: Movie) {
        print("Title: \(movie.title)")
        print("Genres: \(movie.genres.map { "\($0)".capitalized }.joined(separator: ", "))")
        print("Languages: \(movie.languages.map { "\($0)".capitalized }.joined(separator: ", "))")
        print("Duration: \(movie.durationInMinutes) Minutes")
        print("Rating: \("\(movie.rating)".capitalized)")
        print("Release Date: \(movie.releaseDate)")
    }
    
    private func handleUpdateMovie(_ movieParam: Movie) -> Movie {
        var movie = movieParam
        var updating = true
        
        while updating {
            let selectedOption = inputReader.readMenuOption(UpdateMovieOption.allCases)
            switch selectedOption {
            case .updateGenres: handleUpdateGenres()
            case .updateLanguages: handleUpdateLanguages()
            case .updateDuration: handleUpdateDuration()
            case .updateReleaseDate: handleUpdateReleaseDate()
            case .back: handleBack()
            }
        }
        return movie
        
        func handleUpdateGenres() {
            let nonExistingGenres = Set(Movie.Genre.allCases).subtracting(movie.genres)
            if !nonExistingGenres.isEmpty {
                inputReader.readMultipleChoices(mainPrompt: "Select genres to add", nonExistingGenres).forEach { genre in
                    movie.addGenre(genre)
                }
            }
            
            let existingGenres = movie.genres
            if !existingGenres.isEmpty {
                inputReader.readMultipleChoices(mainPrompt: "Select genres to remove", existingGenres).forEach { genre in
                    movie.removeGenre(genre)
                }
            }
        }
        
        func handleUpdateLanguages() {
            let nonExistingLanguages = Set(Movie.Language.allCases).subtracting(movie.languages)
            if !nonExistingLanguages.isEmpty {
                inputReader.readMultipleChoices(mainPrompt: "Select languages to add", nonExistingLanguages).forEach { language in
                    movie.addLanguage(language)
                }
            }
            
            let existingLanguages = movie.languages
            if !existingLanguages.isEmpty {
                inputReader.readMultipleChoices(mainPrompt: "Select languages to remove", existingLanguages).forEach { language in
                    movie.removeLanguage(language)
                }
            }
        }
        
        func handleUpdateDuration() {
            let newDuration = inputReader.readPositiveInt(prompt: "Enter new duration in minutes")
            movie.updateDuration(to: newDuration)
        }
        
        func handleUpdateReleaseDate() {
            let newReleaseDate = inputReader.readDate(prompt: "Enter new release date")
            movie.updateReleaseDate(to: newReleaseDate)
        }
        
        func handleBack() {
            do {
                try manageMovieController.update(movie: movie)
                print("Movie updated successfully.")
            } catch RepoError.notFound {
                print("Movie not found")
            } catch {
                fatalError("Unexpected error: \(error)")
            }
            
            updating = false
        }
    }
    
    private func handleDeleteMovie(_ movie: Movie) -> Movie? {
        if inputReader.readBool(prompt: "Are you sure you want to delete this movie?") {
            do {
                try manageMovieController.remove(movie: movie)
                print("Movie deleted successfully.")
            } catch RepoError.notFound {
                print("Movie not found")
            } catch {
                fatalError("Unexpected error: \(error)")
            }
            return nil
        }
        return movie
    }
    
    private mutating func handleExit() {
        running = false
    }
}
