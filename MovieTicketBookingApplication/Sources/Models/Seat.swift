public struct Seat {
    public enum SeatType: Double {
        case regular = 1, premium = 1.50, vip = 2
    }
    
    public let seatId: String
    public let row: String
    public let seatNumber: Int
    public private(set) var type: SeatType
    
    public init(seatId: String, row: String, seatNumber: Int, type: SeatType) {
        self.seatId = seatId
        self.row = row
        self.seatNumber = seatNumber
        self.type = type
    }
    
    public mutating func changeSeatType(_ type: SeatType) {
        self.type = type
    }
}
