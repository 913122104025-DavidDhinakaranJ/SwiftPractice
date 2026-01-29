import Errors

public struct CinemaHall {
    public struct SeatKey: Hashable {
        let row: String
        let seatNumber: Int
    }
    
    private var nextRowIndex: Int = 0
    
    public let name: String
    public private(set) var seats: [SeatKey : Seat] = [:]
    
    public init(name: String) {
        self.name = name
    }
    
    public mutating func addSeats(numberOfRows: Int, numberOfSeatsPerRow: Int, type: Seat.SeatType) {
        for _ in 0..<numberOfRows {
            let rowLabel = Self.getRowName(nextRowIndex)
            nextRowIndex += 1
            
            for seatNo in 1...numberOfSeatsPerRow {
                let seat = Seat(row: rowLabel, seatNumber: seatNo, type: type)
                seats[SeatKey(row: rowLabel, seatNumber: seatNo)] = seat
            }
        }
    }
    
    public mutating func removeSeat(at key: SeatKey) throws(TheatreError) {
        if seats.removeValue(forKey: key) == nil {
            throw TheatreError.seatNotFound
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
