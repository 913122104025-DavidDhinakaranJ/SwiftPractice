import Errors
import Models
import Repositories

public struct BookingControllerImpl: BookingController {
    private let showRepository: ShowRepository
    
    public init(showRepository: ShowRepository) {
        self.showRepository = showRepository
    }
    
    public func cancelBooking(_ booking: Booking) throws(BookingCancellationError) -> Double {
        if booking.status == .cancelled {
            throw BookingCancellationError.alreadyCancelled
        }
        
        if booking.show.isShowStarted {
            throw BookingCancellationError.showStarted
        }
        
        booking.cancel()
        try? showRepository.update(show: booking.show)
        
        return booking.payment.amount
    }
}
