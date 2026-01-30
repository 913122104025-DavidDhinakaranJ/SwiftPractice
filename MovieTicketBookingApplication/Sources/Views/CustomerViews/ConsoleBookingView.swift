import Contexts
import Controllers
import Errors
import Models
import Utils

struct ConsoleBookingView {
    private enum MenuOption: String, CaseIterable, CustomStringConvertible {
        case viewBookingDetails = "View Booking Details"
        case cancelBooking = "Cancel Booking"
        case exit = "Exit"
        
        var description: String { rawValue }
    }
    
    private let inputReader = ConsoleInputUtil()
    private let appContext = ApplicationContext.getApplicationContext()
    private let bookingController: BookingController
    
    private var running: Bool = false
    
    init(bookingController: BookingController) {
        self.bookingController = bookingController
    }
    
    mutating func runView(for booking: Booking) {
        running = true
        while running {
            let option = inputReader.readMenuOption(MenuOption.allCases)
            switch option {
            case .viewBookingDetails: displayBookingDetails(for: booking)
            case .cancelBooking: cancelBooking(for: booking)
            case .exit: handleExit()
            }
        }
    }
    
    private func displayBookingDetails(for booking: Booking) {
        let seatDescriptions = booking.seats.map { showSeat in
            let seat = showSeat.seat
            return "\(seat.row)\(seat.seatNumber) - \(seat.type)"
        }

        let show = booking.show

        print("Date: \(booking.bookingDate)")
        print("Movie: \(show.movie.title)")
        print("Theatre: \(show.theatre.name)")
        print("Cinema Hall: \(show.cinemaHall.name)")
        print("Seats: \(seatDescriptions.joined(separator: ", "))")
        print("Status: \(booking.status)")
        print("Total Price: \(booking.totalPrice)")
    }
    
    private func cancelBooking(for booking: Booking) {
        guard inputReader.readBool(prompt: "Are you sure you want to cancel this booking?") else { return }
        
        do {
            let refundedAmount = try bookingController.cancelBooking(booking)
            print("Amount of \(refundedAmount) has been refunded.")
        } catch {
            switch error {
            case .alreadyCancelled:
                print("This booking is already cancelled.")
                
            case .showStarted:
                print("The show has already started. Cannot cancel this booking.")
            }
        }
    }
    
    private mutating func handleExit() {
        running = false
    }
}
