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
            case .viewBookingDetails: print(booking.detailedDescription)
            case .cancelBooking: cancelBooking(for: booking)
            case .exit: handleExit()
            }
        }
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
            case .blockedCustomer:
                print("This customer has a blocked status. Cannot cancel this booking.")
            }
        }
    }
    
    private mutating func handleExit() {
        running = false
    }
}
