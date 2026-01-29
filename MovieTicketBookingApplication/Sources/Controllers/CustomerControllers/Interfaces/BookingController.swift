import Errors
import Models

public protocol BookingController {
    func cancelBooking(_ booking: Booking) throws(BookingCancellationError) -> Double
}
