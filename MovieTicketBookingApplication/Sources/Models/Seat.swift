public struct Seat {
    public enum SeatType: Double, CaseIterable {
        case regular = 1, premium = 1.50, vip = 2
    }
    
    public let row: String
    public let seatNumber: Int
    public private(set) var type: SeatType
    
    init(row: String, seatNumber: Int, type: SeatType) {
        self.row = row
        self.seatNumber = seatNumber
        self.type = type
    }
    
    mutating func changeSeatType(_ type: SeatType) {
        self.type = type
    }
}
