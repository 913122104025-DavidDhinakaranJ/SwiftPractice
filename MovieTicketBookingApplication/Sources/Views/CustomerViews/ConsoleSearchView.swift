import Contexts
import Controllers
import Models
import Utils

struct ConsoleSearchView {
    private enum SearchOption: String, CaseIterable, CustomStringConvertible {
        case searchByTitle = "Search by title"
        case searchByGenre = "Search by genre"
        case searchByLanguage = "Search by language"
        case searchByRating = "Search by rating"
        case back = "Back"
        
        var description: String { rawValue }
    }
    
    private let inputReader = ConsoleInputUtil()
    private let appContext = ApplicationContext.getApplicationContext()
    
    private var searching: Bool = false
    
    mutating func runSearchView() {
        searching = true
        while searching {
            let searchOption = inputReader.readMenuOption(SearchOption.allCases)
            switch searchOption {
            case .searchByTitle: handleSearchByTitle()
            case .searchByGenre: handleSearchByGenre()
            case .searchByLanguage: handleSearchByLanguage()
            case .searchByRating: handleSearchByRating()
            case .back: handleBack()
            }
        }
    }
    
    private func handleSearchByTitle() {
        let title = inputReader.readString(prompt: "Enter movie title")
        if(title.isEmpty) { return }
        
        let browseView = ConsoleBrowseView(browseController: BrowseControllerImpl(movieRepository: appContext.getMovieRepository(), criteria: .title(title)))
        browseView.runBrowseView()
    }
    
    private func handleSearchByGenre() {
        let genre = inputReader.readChoiceWithExit(prompt: "Enter Genre Choice", Movie.Genre.allCases)
        guard let genre else { return }
        
        let browseView = ConsoleBrowseView(browseController: BrowseControllerImpl(movieRepository: appContext.getMovieRepository(), criteria: .genre(genre)))
        browseView.runBrowseView()
    }
    
    private func handleSearchByLanguage() {
        let language = inputReader.readChoiceWithExit(prompt: "Enter Language Choice", Movie.Language.allCases)
        guard let language else { return }
        
        let browseView = ConsoleBrowseView(browseController: BrowseControllerImpl(movieRepository: appContext.getMovieRepository(), criteria: .language(language)))
        browseView.runBrowseView()
    }
    
    private func handleSearchByRating() {
        let rating = inputReader.readChoiceWithExit(prompt: "Enter Rating Choice", Movie.Rating.allCases)
        guard let rating else { return }
        
        let browseView = ConsoleBrowseView(browseController: BrowseControllerImpl(movieRepository: appContext.getMovieRepository(), criteria: .rating(rating)))
        browseView.runBrowseView()
    }
    
    private mutating func handleBack() {
        searching = false
    }
}
