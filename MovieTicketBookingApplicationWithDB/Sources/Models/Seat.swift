public struct Seat {
    public enum SeatType: Double, CaseIterable {
        case regular = 1, premium = 1.50, vip = 2
    }
    
    public let id: Int64?
    public let row: String
    public let seatNumber: Int
    public private(set) var type: SeatType
    
    init(row: String, seatNumber: Int, type: SeatType) {
        self.id = nil
        self.row = row
        self.seatNumber = seatNumber
        self.type = type
    }
    
    private init(id: Int64, row: String, seatNumber: Int, type: SeatType) {
        self.id = id
        self.row = row
        self.seatNumber = seatNumber
        self.type = type
    }
    
    public static func rehydrate(id: Int64, row: String, seatNumber: Int, type: SeatType) -> Seat {
        .init(id: id, row: row, seatNumber: seatNumber, type: type)
    }
    
    mutating func changeSeatType(_ type: SeatType) {
        self.type = type
    }
}
