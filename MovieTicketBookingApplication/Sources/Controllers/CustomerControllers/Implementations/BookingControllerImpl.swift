import Errors
import Models
import Repositories

public struct BookingControllerImpl: BookingController {
    private let showRepository: ShowRepository
    
    public init(showRepository: ShowRepository) {
        self.showRepository = showRepository
    }
    
    public func cancelBooking(_ booking: Booking) throws(BookingError) -> Double {
        if booking.status == .cancelled {
            throw BookingError.alreadyCancelled
        }
        
        if booking.show.isShowStarted {
            throw BookingError.showStarted
        }
        
        booking.cancel()
        try? showRepository.update(show: booking.show)
        
        return booking.payment.amount
    }
}
