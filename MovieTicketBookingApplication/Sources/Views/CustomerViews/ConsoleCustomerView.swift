import AuthLib
import Contexts
import Controllers
import Models
import Utils

struct ConsoleCustomerView {
    private enum MenuOption: String, CaseIterable, CustomStringConvertible {
        case searchMovie = "Search Movie"
        case browseMovies = "Browse Movies"
        case viewBookingHistory = "View Booking History"
        case changePassword = "Change Password"
        case logout = "Logout"
        
        var description: String { rawValue }
    }
    
    private let inputReader = ConsoleInputUtil()
    private let appContext = ApplicationContext.getApplicationContext()
    private let customerController: CustomerController
    
    private var login = false
    
    init(customerController: CustomerController) {
        self.customerController = customerController
    }
    
    mutating func runCustomerView() {
        login = true
        while login {
            let menuOption = inputReader.readMenuOption(MenuOption.allCases)
            switch menuOption {
            case .searchMovie: handleSearchMovie()
            case .browseMovies: handleBrowseMovies()
            case .viewBookingHistory: handleViewBookingHistory()
            case .changePassword: handleChangePassword()
            case .logout: handleLogout()
            }
        }
    }
    
    private func handleSearchMovie() {
        var searchView = ConsoleSearchView()
        searchView.runSearchView()
    }
    
    private func handleBrowseMovies() {
        let browseView = ConsoleBrowseView(browseController: BrowseControllerImpl(movieRepository: appContext.getMovieRepository(), criteria: .all))
        browseView.runBrowseView()
    }
    
    private func handleViewBookingHistory() {
        let customer = appContext.getSessionContext().currentUser as! Customer
        let bookings = customer.bookings
        if bookings.isEmpty {
            print("No Booking History Found.")
            return
        }
        
        let booking = inputReader.readChoice(bookings) { booking in
            "Date: \(booking.bookingDate), Movie: \(booking.show.movie.title), Theatre: \(booking.show.theatre.name), Status: \(booking.status)"
        }
        
        if let booking {
            var bookingView = ConsoleBookingView(bookingController: BookingControllerImpl(showRepository: appContext.getShowRepository()))
            bookingView.runBookingView(for: booking)
        }
    }
    
    private func handleChangePassword() {
        let authView = ConsoleAuthView(authController: AuthControllerImpl(userRepository: appContext.getUserRepository(), factory: appContext.getCustomerFactory()))
        authView.changePassword(for: appContext.getSessionContext().currentUser!)
    }
    
    private mutating func handleLogout() {
        login = false
        customerController.save(customer: appContext.getSessionContext().currentUser as! Customer)
        print("Logged out successfully.")
    }
}
