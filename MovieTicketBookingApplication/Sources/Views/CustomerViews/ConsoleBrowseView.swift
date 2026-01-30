import Contexts
import Controllers
import Models
import Utils

struct ConsoleBrowseView {
    private let inputReader = ConsoleInputUtil()
    private let appContext = ApplicationContext.getApplicationContext()
    private let browseController: BrowseController
    
    init(browseController: BrowseController) {
        self.browseController = browseController
    }
    
    func runView() {
        let movies = browseController.getMovies()
        if movies.isEmpty {
            print("No movies available")
            return
        }
        
        let movie = inputReader.readChoiceWithExit(prompt: "Enter Movie Choice", movies) { $0.title }
        if let movie {
            var movieView = ConsoleMovieView(movieController: MovieControllerImpl(showRepository: appContext.getShowRepository()))
            movieView.runView(for: movie)
        }
    }
}
