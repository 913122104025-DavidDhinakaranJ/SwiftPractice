import Controllers
import Errors
import Models
import Utils

struct ConsoleManageTheatreView {
    private enum TheatreManageOption: String, CaseIterable, CustomStringConvertible {
        case addTheatre = "Add Theatre"
        case viewTheatres = "View Theatres"
        case updateTheatre = "Update Theatre"
        case deleteTheatre = "Delete Theatre"
        case exit = "Exit"
        
        var description: String { rawValue }
    }
    
    private let inputReader = ConsoleInputUtil()
    private let manageTheatreController: ManageTheatreController
    
    private var running = false
    
    init(manageTheatreController: ManageTheatreController) {
        self.manageTheatreController = manageTheatreController
    }
    
    mutating func runView() {
        let options: [TheatreManageOption] = [.addTheatre, .viewTheatres, .exit]
        running = true
        
        while running {
            let selectedOption = inputReader.readMenuOption(options)
            
            switch selectedOption {
            case .addTheatre: handleAddTheatre()
            case .viewTheatres: handleViewTheatres()
            case .exit: running = false
            default : fatalError("Unhandled case")
            }
        }
    }
    
    private func handleAddTheatre() {
        let theatreName = inputReader.readString(prompt: "Enter Theatre Name")
        let theatreAddress = inputReader.readString(prompt: "Enter Theatre Address")
        
        let theatre = Theatre(name: theatreName, address: theatreAddress)
        
        do {
            try manageTheatreController.addTheatre(theatre)
            print("Theatre added successfully.")
            handleUpdateTheatre(theatre)
        } catch RepoError.alreadyExists {
            print("Theatre with this name already exists.")
        } catch {
            fatalError("Unexpected error: \(error)")
        }
    }
    
    private func handleViewTheatres() {
        let options: [TheatreManageOption] = [.updateTheatre, .deleteTheatre, .exit]
        let theatres = manageTheatreController.getAllTheatres()
        
        guard !theatres.isEmpty else {
            print("No theatres available.")
            return
        }
        
        var selectedTheatre = inputReader.readChoiceWithExit(prompt: "Enter Theatre Choice", theatres)
        
        while let currentTheatre = selectedTheatre {
            print(currentTheatre.detailedDescription)
            let selectedSubOption = inputReader.readMenuOption(options)
            
            selectedTheatre = switch selectedSubOption {
            case .updateTheatre: handleUpdateTheatre(currentTheatre)
            case .deleteTheatre: handleDeleteTheatre(currentTheatre) ? nil : currentTheatre
            case .exit: nil
            default : fatalError("Unhandled case")
            }
        }
    }
    
    @discardableResult
    private func handleUpdateTheatre(_ theatre: Theatre) -> Theatre? {
        var manageCinemaHallView = ConsoleManageCinemaHallView(theatre: theatre)
        let updatedTheatre = manageCinemaHallView.runView()
        
        do {
            try manageTheatreController.updateTheatre(updatedTheatre)
            print("Theatre updated successfully.")
            return updatedTheatre
        } catch RepoError.notFound {
            print("Theatre not found")
        } catch {
            fatalError("Unexpected error: \(error)")
        }
        
        return nil
    }
    
    private func handleDeleteTheatre(_ theatre: Theatre) -> Bool {
        if inputReader.readBool(prompt: "Are you sure you want to delete this Theatre?") {
            do {
                try manageTheatreController.deleteTheatre(theatre)
                print("Theatre deleted successfully.")
            } catch RepoError.notFound {
                print("Theatre not found")
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
