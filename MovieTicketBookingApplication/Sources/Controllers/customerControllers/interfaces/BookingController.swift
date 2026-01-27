import Models

public protocol BookingController {
    func getBooking() -> Booking
    func cancelBooking()
}
