import AuthLib
import Controllers
import Contexts
import Models
import Utils

struct ConsoleShowView {
    private enum MenuOption: String, CaseIterable, CustomStringConvertible {
        case viewDetails = "View Details"
        case BookTickets = "Book Tickets for Show"
        case exit = "Exit"
        
        var description: String { rawValue }
    }
    
    private let inputReader = ConsoleInputUtil()
    private let appContext = ApplicationContext.getApplicationContext()
    private let showController: ShowController
    
    private var running = false
    
    init(showController: ShowController) {
        self.showController = showController
    }
    
    public mutating func runView(for show: Show) {
        running = true
        while running {
            let option = inputReader.readMenuOption(MenuOption.allCases)
            switch option {
            case .viewDetails: showDetails(for: show)
            case .BookTickets: handleBookTickets(for: show)
            case .exit: running = false
            }
        }
    }
    
    private func showDetails(for show: Show) {
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
    
    private func handleBookTickets(for show: Show) {
        if show.isShowStarted {
            print("Cannot book tickets for a show that has already started.")
            return
        }
        
        if !show.isSeatsAvailable {
            print("No more seats available for this show.")
            return
        }
        
        guard let customer = appContext.getSessionContext().currentUser as! Customer? ?? handleGuestUser() else { return }
        
        let selectedSeats = inputReader.readMultipleChoices(mainPrompt: "Select Seats to Book", show.getAvailableSeats()) { showSeat in
            let seat = showSeat.seat
            return "\(seat.row)\(seat.seatNumber) - \(seat.type)"
        }
        .sorted { showSeat1, showSeat2 in
            let seat1 = showSeat1.seat
            let seat2 = showSeat2.seat
            if seat1.row != seat2.row {
                return seat1.row < seat2.row
            }
            return seat1.seatNumber < seat2.seatNumber
        }
        
        if selectedSeats.isEmpty { return }
        
        let booking = Booking(customer: customer, show: show, seats: selectedSeats)
        var paymentView = ConsolePaymentView(payment: booking.payment)
        
        if paymentView.handlePayment(amount: booking.totalPrice) {
            showController.confirmBooking(booking: booking)
        }
    }
    
    private mutating func handleExit() {
        running = false
    }
    
    private func handleGuestUser() -> Customer? {
        print("You need to log in as a customer to book tickets.")
        while true {
            guard inputReader.readBool(prompt: "Do you want to continue?") else { return nil }
            
            if inputReader.readBool(prompt: "New User?") { return handleNewUser() }
            return handleExistingUser()
        }
        
        func handleNewUser() -> Customer? {
            let authView = ConsoleAuthView(authController: AuthControllerImpl(userRepository: appContext.getUserRepository(), factory: appContext.getCustomerFactory()))
            let customer = authView.handleRegistration() as! Customer?
            
            if let customer = customer {
                print("Registration Successful!")
                appContext.getSessionContext().login(user: customer)
                return customer
            }
            
            return nil
        }
        
        func handleExistingUser() -> Customer? {
            let authView = ConsoleAuthView(authController: AuthControllerImpl(userRepository: appContext.getUserRepository(), factory: appContext.getCustomerFactory()))
            let user = authView.handleLogin() as! User?
            
            if let customer = user as? Customer {
                print("Login Successful!")
                appContext.getSessionContext().login(user: customer)
                return customer
            }
            
            return nil
        }
    }
}
