import Errors
import Models
import Utils

struct ConsoleManageCinemaHallView {
    private enum CinemaHallManageOption: String, CaseIterable, CustomStringConvertible {
        case addCinemaHall = "Add cinema hall"
        case viewCinemaHalls = "View cinema halls"
        case updateCinemaHall = "Update cinema hall"
        case deleteCinemaHall = "Delete cinema hall"
        case exit = "Exit"
        
        var description: String { rawValue }
    }
    
    private let inputReader = ConsoleInputUtil()
    private var theatre: Theatre
    
    private var running = false
    
    init(theatre: Theatre) {
        self.theatre = theatre
    }
    
    mutating func runView() -> Theatre {
        let options: [CinemaHallManageOption] = [.addCinemaHall, .viewCinemaHalls, .exit]
        running = true
        
        while running {
            let selectedOption = inputReader.readMenuOption(options)
            
            switch selectedOption {
            case .addCinemaHall: handleAddCinemaHall()
            case .viewCinemaHalls: handleViewCinemaHalls()
            case .exit: handleExit()
            default : fatalError("Unhandled case")
            }
        }
        
        return theatre
    }
    
    private mutating func handleAddCinemaHall() {
        let cinemaHallName = inputReader.readString(prompt: "Enter cinema hall name")
        
        do {
            try theatre.addHall(cinemaHallName)
            print("Cinema hall added successfully.")
            handleUpdateCinemaHall(theatre[cinemaHallName]!)
        } catch TheatreError.cinemaHallAlreadyExists {
            print("Cinema hall with name \(cinemaHallName) already exists.")
        } catch {
            fatalError("Unexpected error: \(error)")
        }
    }
    
    private mutating func handleViewCinemaHalls() {
        let options: [CinemaHallManageOption] = [.updateCinemaHall, .deleteCinemaHall, .exit]
        let cinemaHalls = theatre.getCinemaHalls()
        
        guard !cinemaHalls.isEmpty else {
            print("No cinema halls available in this theatre.")
            return
        }
        
        var selectedCinemaHall = inputReader.readChoiceWithExit(prompt: "Enter Cinema Hall Choice", cinemaHalls)
        
        while let currentCinemaHall = selectedCinemaHall {
            print(currentCinemaHall.detailedDescription)
            let selectedSubOption = inputReader.readMenuOption(options)
            
            selectedCinemaHall = switch selectedSubOption {
            case .updateCinemaHall: handleUpdateCinemaHall(currentCinemaHall)
            case .deleteCinemaHall: handleDeleteCinemaHall(currentCinemaHall) ? nil : currentCinemaHall
            case .exit: nil
            default: fatalError("Unhandled case")
            }
        }
    }
    
    @discardableResult
    private mutating func handleUpdateCinemaHall(_ cinemaHall: CinemaHall) -> CinemaHall? {
        var manageSeatView = ConsoleManageSeatView(theatre: theatre, cinemaHallName: cinemaHall.name)!
        theatre = manageSeatView.runView()
        print("CinemaHall updated successfully.")
        return theatre[cinemaHall.name]
    }
    
    private mutating func handleDeleteCinemaHall(_ cinemaHall: CinemaHall) -> Bool {
        if inputReader.readBool(prompt: "Are you sure you want to delete this CinemaHall?") {
            do {
                try theatre.removeHall(cinemaHall.name)
                print("CinemaHall deleted successfully.")
            } catch TheatreError.cinemaHallNotFound {
                print("CinemaHall not found")
            } catch {
                fatalError("Unexpected error: \(error)")
            }
            return true
        }
        return false
    }
    
    private mutating func handleExit() {
        running = false
    }
}
