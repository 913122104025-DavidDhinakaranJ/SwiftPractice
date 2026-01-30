import Contexts
import Controllers
import Models
import Utils

struct ConsoleAdminView {
    private enum MenuOption: String, CaseIterable, CustomStringConvertible {
        case manageTheatres = "Manage Theatres"
        case manageMovies = "Manage Movies"
        case manageShows = "Manage Shows"
        case manageCustomers = "Manage Customers"
        case manageAdmins = "Manage Admins"
        case logout = "Logout"
        
        var description: String { rawValue }
    }
    
    private let inputReader = ConsoleInputUtil()
    private let appContext = ApplicationContext.getApplicationContext()
    
    private var login = false
    
    mutating func runView() {
        login = true
        while login {
            let option = inputReader.readMenuOption(MenuOption.allCases)
            switch option {
            case .manageTheatres: handleManageTheatres()
            case .manageMovies: handleManageMovies()
            case .manageShows: handleManageShows()
            case .manageCustomers: handleManageCustomers()
            case .manageAdmins: handleManageAdmins()
            case .logout: handleLogout()
            }
        }
    }
    
    private func handleManageTheatres() {
        let admin = appContext.getSessionContext().currentUser as! Admin
        guard admin.hasPrivilege(.theatre) else {
            print("You don't have the privilege to manage theatres.")
            return
        }
    }
    
    private func handleManageMovies() {
        let admin = appContext.getSessionContext().currentUser as! Admin
        guard admin.hasPrivilege(.movie) else {
            print("You don't have the privilege to manage movies.")
            return
        }
    }
    
    private func handleManageShows() {
        let admin = appContext.getSessionContext().currentUser as! Admin
        guard admin.hasPrivilege(.show) else {
            print("You don't have the privilege to manage shows.")
            return
        }
    }
    
    private func handleManageCustomers() {
        let admin = appContext.getSessionContext().currentUser as! Admin
        guard admin.hasPrivilege(.customer) else {
            print("You don't have the privilege to manage customers.")
            return
        }
    }
    
    private func handleManageAdmins() {
        let admin = appContext.getSessionContext().currentUser as! Admin
        guard admin.hasPrivilege(.admin) else {
            print("You don't have the privilege to manage admins.")
            return
        }
        
        var manageAdminView = ConsoleManageAdminView(manageAdminController: ManageAdminControllerImpl(userRepository: appContext.getUserRepository()))
        manageAdminView.runView()
    }
    
    private mutating func handleLogout() {
        login = false
        print("Logged out successfully.")
    }
}
