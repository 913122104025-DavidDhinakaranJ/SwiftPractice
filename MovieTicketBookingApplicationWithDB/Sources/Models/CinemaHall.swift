import Errors

public struct CinemaHall {
    private struct SeatKey: Hashable {
        let row: String
        let seatNumber: Int
    }
    
    private var nextRowIndex: Int = 0
    
    public let id: Int64?
    public let name: String
    private var seats: [SeatKey : Seat] = [:]
    
    init(name: String) {
        self.id = nil
        self.name = name
    }
    
    private init (id: Int64, name: String, seats: [SeatKey: Seat]) {
        self.id = id
        self.name = name
        self.seats = seats
    }
    
    public static func rehydrate(id: Int64, name: String, seats: [Seat]) -> CinemaHall {
        seats.reduce(into: CinemaHall(id: id, name: name, seats: [:])) { result, seat in
            let key = SeatKey(row: seat.row, seatNumber: seat.seatNumber)
            result.seats[key] = seat
        }
    }
    
    mutating func addSeats(numberOfRows: Int, numberOfSeatsPerRow: Int, type: Seat.SeatType) {
        for _ in 0..<numberOfRows {
            let rowLabel = Self.getRowName(nextRowIndex)
            nextRowIndex += 1
            
            for seatNo in 1...numberOfSeatsPerRow {
                let seat = Seat(row: rowLabel, seatNumber: seatNo, type: type)
                seats[SeatKey(row: rowLabel, seatNumber: seatNo)] = seat
            }
        }
    }
    
    public func getSeats() -> [Seat] {
        seats.values.sorted { seat1, seat2 in
            if seat1.row != seat2.row {
                return seat1.row < seat2.row
            }
            return seat1.seatNumber < seat2.seatNumber
        }
    }
    
    mutating func changeSeatType(row: String, seatNumber: Int, to newType: Seat.SeatType) throws(TheatreError) {
        let key = SeatKey(row: row, seatNumber: seatNumber)
        guard seats[key] != nil else { throw TheatreError.seatNotFound(row: row, seatNumber: seatNumber) }
        seats[key]!.changeSeatType(newType)
    }
    
    mutating func removeSeat(row: String, seatNumber: Int) throws(TheatreError) {
        let key = SeatKey(row: row, seatNumber: seatNumber)
        if seats.removeValue(forKey: key) == nil { throw TheatreError.seatNotFound(row: row, seatNumber: seatNumber) }
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
    
    public subscript(row: String, seatNumber: Int) -> Seat? {
        let key = SeatKey(row: row, seatNumber: seatNumber)
        return seats[key]
    }
}
