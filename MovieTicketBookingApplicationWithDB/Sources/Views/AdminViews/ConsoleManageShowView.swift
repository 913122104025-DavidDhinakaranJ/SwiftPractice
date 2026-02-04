import Controllers
import Foundation
import Errors
import Models
import Utils

struct ConsoleManageShowView {
    private enum ShowManageOption: String, CaseIterable, CustomStringConvertible {
        case addShow = "Add Show"
        case viewShows = "View Shows"
        case updateShow = "Update Show Timings"
        case deleteShow = "Delete Show"
        case exit = "Exit"
        
        var description: String { rawValue }
    }
    
    private let inputReader = ConsoleInputUtil()
    private let manageShowController: ManageShowController
    
    private var running = false
    
    init(manageShowController: ManageShowController) {
        self.manageShowController = manageShowController
    }
    
    mutating func runView() {
        let options: [ShowManageOption] = [.addShow, .viewShows, .exit]
        running = true
        
        while running {
            let selectedOption = inputReader.readMenuOption(options)
            
            switch selectedOption {
            case .addShow: handleAddShow()
            case .viewShows: handleViewShows()
            case .exit: handleExit()
            default: fatalError("Unhandled case")
            }
        }
    }
    
    private func handleAddShow() {
        let theatre = inputReader.readChoice(prompt:"Enter Theatre Choice", manageShowController.getAllTheatres())
        let cinemaHall = inputReader.readChoice(prompt: "Enter Cinema Hall Choice" ,theatre.getCinemaHalls())
        let movie = inputReader.readChoice(prompt: "Enter Movie Choice", manageShowController.getAllMovies())
        let basePrice = inputReader.readAmount(prompt: "Enter the base price")
        
        repeat {
            let startTime = inputReader.readFutureDateTime(prompt: "Enter the start time")
            let breakTime = inputReader.readPositiveInt(prompt: "Enter the break time in minutes")
            
            do {
                let show = Show(movie: movie, theatre: theatre, cinemaHall: cinemaHall, startTime: startTime, breakTime: breakTime, price: basePrice)
                try manageShowController.addShow(show)
                print("Show added successfully")
            } catch RepoError.alreadyExists {
                print("A show has already been scheduled at that same time. Try again.")
            } catch {
                fatalError("Unexpected error: \(error)")
            }
            
        } while inputReader.readBool(prompt: "Do you want to add more shows?")
    }
    
    private func handleViewShows() {
        let options: [ShowManageOption] = [.updateShow, .deleteShow, .exit]
        var selectedShow = inputReader.readChoiceWithExit(prompt: "Enter Show Choice", manageShowController.getAllShows())
                
        while let currentShow = selectedShow {
            print(currentShow.detailedDescription)
            let selectedSubOption = inputReader.readMenuOption(options)
            
            selectedShow = switch selectedSubOption {
            case .updateShow: handleUpdateShow(currentShow)
            case .deleteShow: handleDeleteShow(currentShow) ? nil : currentShow
            case .exit: nil
            default : fatalError("Unhandled case")
            }
        }
    }
    
    private func handleUpdateShow(_ showParam: Show) -> Show? {
        let show = showParam
        let startTime = inputReader.readFutureDateTime(prompt: "Enter new start time")
        let breakTime = inputReader.readPositiveInt(prompt: "Enter break time")
        show.setTime(startTime: startTime, breakTime: breakTime)
        
        do {
            try manageShowController.updateShow(show)
            print("Show updated successfully")
            return show
        } catch RepoError.notFound {
            print("Show not found")
        } catch {
            fatalError("Unexpected error: \(error)")
        }
        return nil
    }
    
    private func handleDeleteShow(_ show: Show) -> Bool {
        if inputReader.readBool(prompt: "Are you sure you want to delete this Show?") {
            do {
                try manageShowController.removeShow(show)
                print("Show deleted successfully")
            } catch RepoError.notFound {
                print("Show not found")
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
