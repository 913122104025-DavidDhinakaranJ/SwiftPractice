public final class ShowSeat {
    private enum Status {
        case available, booked
    }
    
    public let showSeatId: String
    public let seat: Seat
    public let show: Show
    private var status: Status = .available
    public var isAvailable: Bool { status == .available }
    
    public init(showSeatId: String, seat: Seat, show: Show) {
        self.showSeatId = showSeatId
        self.seat = seat
        self.show = show
    }
    
    public func book() {
        status = .booked
    }
    
    public func unbook() {
        status = .available
    }
}
