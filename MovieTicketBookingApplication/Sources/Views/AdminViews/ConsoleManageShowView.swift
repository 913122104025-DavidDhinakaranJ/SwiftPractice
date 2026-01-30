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
        running = true
        while running {
            let options: [ShowManageOption] = [.addShow, .viewShows, .exit]
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
        let theatre = inputReader.readChoice(prompt:"Enter Theatre Choice", manageShowController.getAllTheatres()) { theatre in theatre.name }
        let cinemaHall = inputReader.readChoice(prompt: "Enter Cinema Hall Choice" ,theatre.getCinemaHalls()) { hall in hall.name }
        let movie = inputReader.readChoice(prompt: "Enter Movie Choice", manageShowController.getAllMovies()) { movie in movie.title }
        let basePrice = inputReader.readAmount(prompt: "Enter the base price")
        
        repeat {
            let startTime = inputReader.readFutureDateTime(prompt: "Enter the start time")
            let breakTime = inputReader.readPositiveInt(prompt: "Enter the break time in minutes")
            
            do {
                let show = Show(movie: movie, theatre: theatre, cinemaHall: cinemaHall, startTime: startTime, breakTime: breakTime, price: basePrice)
                try manageShowController.addShow(show: show)
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
        var selectedShow = inputReader.readChoiceWithExit(prompt: "Enter Show Choice", manageShowController.getAllShows()) { show in "\(show.movie.title) at \(show.cinemaHall.name) on \(show.startTime)" }
                
        while let currentShow = selectedShow {
            displayShowDetails(currentShow)
            let selectedSubOption = inputReader.readMenuOption(options)
            
            selectedShow = switch selectedSubOption {
            case .updateShow: handleUpdateShow(currentShow)
            case .deleteShow: handleDeleteShow(currentShow)
            case .exit: nil
            default : fatalError("Unhandled case")
            }
        }
    }
    
    private func displayShowDetails(_ show: Show) {
        print("Movie: \(show.movie.title)")
        print("Theatre: \(show.theatre.name)")
        print("Cinema Hall: \(show.cinemaHall.name)")
        print("Timing: \(show.startTime) to \(show.endTime)")
        print("Base Price: \(show.price)")
        if show.isSeatsAvailable {
            print("Available Seats:")
            show.getAvailableSeats().forEach { showSeat in
                let seat = showSeat.seat
                print("\(seat.row)\(seat.seatNumber) - \(seat.type)")
            }
        }
    }
    
    private func handleUpdateShow(_ showParam: Show) -> Show {
        let show = showParam
        let startTime = inputReader.readFutureDateTime(prompt: "Enter new start time")
        let breakTime = inputReader.readPositiveInt(prompt: "Enter break time")
        show.setTime(startTime: startTime, breakTime: breakTime)
        
        do {
            try manageShowController.updateShow(show: show)
        } catch RepoError.notFound {
            print("Show not found")
        } catch {
            fatalError("Unexpected error: \(error)")
        }
        
        return show
    }
    
    private func handleDeleteShow(_ show: Show) -> Show? {
        if inputReader.readBool(prompt: "Are you sure you want to delete this Show?") {
            do {
                try manageShowController.removeShow(show: show)
            } catch RepoError.notFound {
                print("Show not found")
            } catch {
                fatalError("Unexpected error: \(error)")
            }
            return nil
        }
        return show
    }
    
    private mutating func handleExit() {
        running = false
    }
}
