import Errors

public struct Theatre {
    public let name: String
    public let address: String
    private var halls: [String : CinemaHall] = [:]
    
    public init(name: String, address: String) {
        self.name = name
        self.address = address
    }
    
    public mutating func addHall(_ cinemaHallName: String) throws(TheatreError) {
        guard halls[cinemaHallName] == nil else { throw TheatreError.cinemaHallAlreadyExists(name: cinemaHallName) }
        
        let newHall = CinemaHall(name: cinemaHallName)
        halls[cinemaHallName] = newHall
    }
    
    public mutating func addSeatsToHall(_ cinemaHallName: String, numberOfRows: Int, numberOfSeatsPerRow: Int, type: Seat.SeatType) throws(TheatreError) {
        guard halls[cinemaHallName] != nil else { throw TheatreError.cinemaHallNotFound(name: cinemaHallName) }
        halls[cinemaHallName]!.addSeats(numberOfRows: numberOfRows, numberOfSeatsPerRow: numberOfSeatsPerRow, type: type)
    }
    
    public func getCinemaHalls() -> [CinemaHall] {
        halls.values.sorted { $0.name < $1.name }
    }
    
    public mutating func changeSeatType(inHall cinemaHallName: String, row: String, seatNumber: Int, type: Seat.SeatType) throws(TheatreError) {
        guard halls[cinemaHallName] != nil else { throw TheatreError.cinemaHallNotFound(name: cinemaHallName) }
        try halls[cinemaHallName]!.changeSeatType(row: row, seatNumber: seatNumber, to: type)
    }
    
    public mutating func removeSeatInHall(_ cinemaHallName: String, row: String, seatNumber: Int) throws(TheatreError) {
        guard halls[cinemaHallName] != nil else { throw TheatreError.cinemaHallNotFound(name: cinemaHallName) }
        try halls[cinemaHallName]!.removeSeat(row: row, seatNumber: seatNumber)
    }

    public mutating func removeHall(_ cinemaHallName: String) throws(TheatreError) {
        if halls.removeValue(forKey: cinemaHallName) == nil {
            throw TheatreError.cinemaHallNotFound(name: cinemaHallName)
        }
    }
    
    public subscript (cinemaHallName: String) -> CinemaHall? {
        halls[cinemaHallName]
    }
}
