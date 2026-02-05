public final class ShowSeat: Hashable {
    public enum Status {
        case available, booked
    }
    
    public let seat: Seat
    public unowned let show: Show
    public private(set) var status: Status = .available
    public var isAvailable: Bool { status == .available }
    
    public init(seat: Seat, show: Show) {
        self.seat = seat
        self.show = show
    }
    
    private init(seat: Seat, show: Show, status: Status) {
        self.seat = seat
        self.show = show
        self.status = status
    }
    
    public static func rehydrate(seat: Seat, show: Show, status: Status) -> ShowSeat {
        .init(seat: seat, show: show, status: status)
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
