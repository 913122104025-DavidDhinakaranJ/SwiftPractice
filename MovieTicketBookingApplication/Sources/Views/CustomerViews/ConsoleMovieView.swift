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
    
    mutating func runView(for movie: Movie) {
        running = true
        while running {
            let movieOption = inputReader.readMenuOption(MenuOption.allCases)
            switch movieOption {
            case .viewDetails: print(movie.detailedDescription)
            case .viewShows: handleViewShows(for: movie)
            case .exit: handleExit()
            }
        }
    }
    
    private func handleViewShows(for movie: Movie) {
        let shows = movieController.getShows(for: movie)
        if shows.isEmpty {
            print("No showtimes available for this movie.")
            return
        }
        
        let show = inputReader.readChoiceWithExit(shows)
        
        if let show {
            var showView = ConsoleShowView(showController: ShowControllerImpl(showRepository: appContext.getShowRepository()))
            showView.runView(for: show)
        }
    }
    
    private mutating func handleExit() {
        running = false
    }
}
