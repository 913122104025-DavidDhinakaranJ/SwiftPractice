import Errors
import Models
import Utils

struct ConsoleManageSeatView {
    private enum SeatManageOption: String, CaseIterable, CustomStringConvertible {
        case addSeat = "Add seat"
        case viewSeats = "View seats"
        case updateSeat = "Update seat type"
        case deleteSeat = "Delete seat"
        case exit = "Exit"
        
        var description: String { rawValue }
    }
    
    private let inputReader = ConsoleInputUtil()
    private var theatre: Theatre
    private var cinemaHallName: String
    
    private var running = false
    
    init?(theatre: Theatre, cinemaHallName: String) {
        if theatre[cinemaHallName] == nil { return nil }
        self.theatre = theatre
        self.cinemaHallName = cinemaHallName
    }
    
    mutating func runView() -> Theatre {
        let options: [SeatManageOption] = [.addSeat, .viewSeats, .exit]
        running = true
        
        while running {
            let selectedOption = inputReader.readMenuOption(options)
            
            switch selectedOption {
            case .addSeat: handleAddSeat()
            case .viewSeats: handleViewSeats()
            case .exit: handleExit()
            default : fatalError("Unhandled case")
            }
        }
        
        return theatre
    }
    
    private mutating func handleAddSeat() {
        let seatType = inputReader.readChoice(prompt: "Enter seat type Choice", Seat.SeatType.allCases)
        let numberOfRows = inputReader.readPositiveInt(prompt: "Enter number of rows")
        let numberOfSeatsPerRow = inputReader.readPositiveInt(prompt: "Enter number of seats per row")
        
        do {
            try theatre.addSeatsToHall(cinemaHallName, numberOfRows: numberOfRows, numberOfSeatsPerRow: numberOfSeatsPerRow, type: seatType)
            print("Seats added successfully")
        } catch TheatreError.cinemaHallNotFound {
            print("Cinema hall not found")
        } catch {
            fatalError("Unexpected error: \(error)")
        }
    }
    
    private mutating func handleViewSeats() {
        let options: [SeatManageOption] = [.updateSeat, .deleteSeat, .exit]
        
        guard let seats = theatre[cinemaHallName]?.getSeats(), !seats.isEmpty else {
            print("No seats to manage")
            return
        }
        
        var selectedSeat = inputReader.readChoiceWithExit(prompt: "Select a seat to manage", seats)
        
        while let currentSeat = selectedSeat {
            print(currentSeat.detailedDescription)
            let selectedSubOption = inputReader.readMenuOption(options)
            
            selectedSeat = switch selectedSubOption {
            case .updateSeat: handleUpdateSeat(currentSeat)
            case .deleteSeat: handleDeleteSeat(currentSeat) ? nil : currentSeat
            case .exit: nil
            default: fatalError("Unhandled case")
            }
        }
    }
    
    private mutating func handleUpdateSeat(_ seat: Seat) -> Seat? {
        let newType = inputReader.readChoice(prompt: "Enter new seat type", Seat.SeatType.allCases)
        do {
            try theatre.changeSeatType(inHall: cinemaHallName, row: seat.row, seatNumber: seat.seatNumber, type: newType)
            print("Seat updated successfully.")
            return theatre[cinemaHallName]?[seat.row, seat.seatNumber]
        } catch TheatreError.cinemaHallNotFound {
            print("Cinema hall not found")
        } catch TheatreError.seatNotFound {
            print("Seat not found")
        } catch {
            fatalError("Unexpected error: \(error)")
        }
        
        return nil
    }
    
    private mutating func handleDeleteSeat(_ seat: Seat) -> Bool {
        if inputReader.readBool(prompt: "Are you sure you want to delete this Seat?") {
            do {
                try theatre.removeSeatInHall(cinemaHallName, row: seat.row, seatNumber: seat.seatNumber)
                print("Seat deleted successfully.")
            } catch TheatreError.cinemaHallNotFound {
                print("Cinema hall not found")
            } catch TheatreError.seatNotFound {
                print("Seat not found")
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
