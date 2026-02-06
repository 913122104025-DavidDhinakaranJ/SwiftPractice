public final class ShowSeat: Hashable {
    public enum Status {
        case available, booked
    }
    
    public let id: Int64?
    public let seat: Seat
    public unowned let show: Show
    public private(set) var status: Status = .available
    public var isAvailable: Bool { status == .available }
    
    public init(seat: Seat, show: Show) {
        self.id = nil
        self.seat = seat
        self.show = show
    }
    
    private init(id: Int64, seat: Seat, show: Show, status: Status) {
        self.id = id
        self.seat = seat
        self.show = show
        self.status = status
    }
    
    public static func rehydrate(id: Int64, seat: Seat, show: Show, status: Status) -> ShowSeat {
        .init(id: id, seat: seat, show: show, status: status)
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
