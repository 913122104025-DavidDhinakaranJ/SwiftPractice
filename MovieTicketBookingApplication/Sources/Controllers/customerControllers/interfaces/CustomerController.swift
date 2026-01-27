import Models

public protocol CustomerController {
    func getBookingHistory() -> [Booking]
}
