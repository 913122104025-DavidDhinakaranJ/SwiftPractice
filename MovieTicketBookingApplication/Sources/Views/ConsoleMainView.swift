import AuthLib
import Contexts
import Controllers
import Models
import Utils

public struct ConsoleMainView {
    private enum MenuOption: String, CaseIterable, CustomStringConvertible {
        case register = "New User Registration"
        case login = "User Login"
        case search = "Search Movie"
        case browse = "Browse Movies"
        case exit = "Exit"
        
        var description: String { rawValue }
    }
    
    private let inputReader = ConsoleInputUtil()
    private let appContext = ApplicationContext.getApplicationContext()
    
    private var running = false
    
    public init() {}
    
    public mutating func runMainView() {
        running = true
        
        while running {
            if let user = appContext.getSessionContext().currentUser {
                handleRunLoginView(user)
            }
            
            let option = inputReader.readMenuOption(MenuOption.allCases)
            switch option {
            case .register: handleRegistration()
            case .login: handleLogin()
            case .search: handleSearchMovie()
            case .browse: handleBrowseMovies()
            case .exit: handleExit()
            }
            
        }
    }
    
    private func handleRegistration() {
        let authView = ConsoleAuthView(authController: AuthControllerImpl(userRepository: appContext.getUserRepository(), factory: appContext.getCustomerFactory()))
        let user = authView.handleRegistration() as! User?
        
        if let user = user {
            print("Registration Successful!")
            handleRunLoginView(user)
        }
    }
    
    private func handleLogin() {
        let authView = ConsoleAuthView(authController: AuthControllerImpl(userRepository: appContext.getUserRepository(), factory: appContext.getCustomerFactory()))
        let user = authView.handleLogin() as! User?
        
        if let user = user {
            guard !user.isBlocked else {
                print("Your account has been temporarily blocked.")
                return
            }
            print("Registration Successful!")
            handleRunLoginView(user)
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
    
    private mutating func handleExit() {
        running = false
        print("Exiting Application...")
    }
    
    private func handleRunLoginView(_ user: User) {
        appContext.getSessionContext().login(user: user)
        switch user.role {
        case .customer:
            var customerView = ConsoleCustomerView(customerController: CustomerControllerImpl(userRepository: appContext.getUserRepository()))
            customerView.runCustomerView()
        case .admin:
            print("Admin View")
        }
        appContext.getSessionContext().logout()
    }
}
