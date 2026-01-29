import Contexts
import Controllers
import Models
import Utils

struct ConsoleMovieView {
    private enum MenuOption: String, CaseIterable, CustomStringConvertible {
        case viewDetails = "View Movie Details"
        case viewShows = "View Movie Showtimes"
        case exit = "Exit"
        
        var description: String { rawValue }
    }
    
    private let inputReader = ConsoleInputUtil()
    private let appContext = ApplicationContext.getApplicationContext()
    private let movieController: MovieController
    
    private var running = false
    
    init(movieController: MovieController) {
        self.movieController = movieController
    }
    
    mutating func runMovieView(for movie: Movie) {
        running = true
        while running {
            let movieOption = inputReader.readMenuOption(MenuOption.allCases)
            switch movieOption {
            case .viewDetails: displayMovieDetails(for: movie)
            case .viewShows: handleViewShows(for: movie)
            case .exit: handleExit()
            }
        }
    }
    
    private func displayMovieDetails(for movie: Movie) {
        print("Title: \(movie.title)")
        print("Genres: \(movie.genres.map { "\($0)".capitalized }.joined(separator: ", "))")
        print("Languages: \(movie.languages.map { "\($0)".capitalized }.joined(separator: ", "))")
        print("Duration: \(movie.durationInMinutes) Minutes")
        print("Rating: \("\(movie.rating)".capitalized)")
        print("Release Date: \(movie.releaseDate)")
    }
    
    private func handleViewShows(for movie: Movie) {
        let shows = movieController.getShows(for: movie)
        if shows.isEmpty {
            print("No showtimes available for this movie.")
            return
        }
        
        let show = inputReader.readChoice(shows) { show in
            "Theatre: \(show.theatre.name)  |  CinemaHall: \(show.cinemaHall.name)  |  Time: \(show.startTime) to \(show.endTime)"
        }
        
        if let show {
            var showView = ConsoleShowView(showController: ShowControllerImpl(showRepository: appContext.getShowRepository()))
            showView.runShowView(for: show)
        }
    }
    
    private mutating func handleExit() {
        running = false
    }
}
