public final class ShowSeat: Hashable {
    private enum Status {
        case available, booked
    }
    
    public let seat: Seat
    public unowned let show: Show
    private var status: Status = .available
    public var isAvailable: Bool { status == .available }
    
    public init(seat: Seat, show: Show) {
        self.seat = seat
        self.show = show
    }
    
    public func book() {
        status = .booked
    }
    
    public func unbook() {
        status = .available
    }
    
    public static func == (lhs: ShowSeat, rhs: ShowSeat) -> Bool {
        lhs === rhs
    }
    
    public func hash(into hasher: inout Hasher) {
        ObjectIdentifier(self).hash(into: &hasher)
    }
}
