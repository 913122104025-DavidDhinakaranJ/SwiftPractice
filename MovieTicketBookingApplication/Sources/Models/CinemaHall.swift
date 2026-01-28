public struct CinemaHall {
    private var seatIdCounter: Int = 0
    private var nextRowIndex: Int = 0
    
    public let hallId: String
    public let name: String
    public private(set) var seats: [Seat] = []
    
    public init(hallId: String, name: String) {
        self.hallId = hallId
        self.name = name
    }
    
    public mutating func addSeats(numberOfRows: Int, numberOfSeatsPerRow: Int, type: Seat.SeatType) {
        for _ in 0..<numberOfRows {
            let rowLabel = Self.getRowName(nextRowIndex)
            nextRowIndex += 1
            
            for seatNo in 1...numberOfSeatsPerRow {
                seatIdCounter += 1
                let seatId = "SEAT_\(hallId)_\(seatIdCounter)"
                let seat = Seat(seatId: seatId, row: rowLabel, seatNumber: seatNo, type: type)
                seats.append(seat)
            }
        }
    }
    
    private static func getRowName(_ index: Int) -> String {
        var rowName: String = ""
        var currentIndex = index + 1
        
        while currentIndex > 0 {
            currentIndex -= 1
            
            let remainder = currentIndex % 26
            let asciiA = UnicodeScalar("A").value
            
            if let scalar = UnicodeScalar(asciiA + UInt32(remainder)) {
                rowName.insert(Character(scalar), at: rowName.startIndex)
            }
            
            currentIndex /= 26
        }
        
        return rowName
    }
}
