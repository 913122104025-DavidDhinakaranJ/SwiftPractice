import Models
import Repositories

public struct ShowControllerImpl: ShowController {
    private let showRepository: ShowRepository
    
    public init(showRepository: ShowRepository) {
        self.showRepository = showRepository
    }
    
    public func confirmBooking(booking: Booking) {
        booking.confirm()
        try? showRepository.update(show: booking.show)
    }
}
