import Errors

public class Theatre {
    public private(set) var id: Int64?
    public let name: String
    public let address: String
    private var halls: [String : CinemaHall] = [:]
    
    public init(name: String, address: String) {
        self.id = nil
        self.name = name
        self.address = address
    }
    
    private init(id: Int64, name: String, address: String, halls: [String : CinemaHall]) {
        self.id = id
        self.name = name
        self.address = address
        self.halls = halls
    }
    
    public static func rehydrate(id: Int64, name: String, address: String, halls: [CinemaHall]) -> Theatre {
        halls.reduce(into: Theatre(id: id, name: name, address: address, halls: [:])) { result, hall in
            result.halls[hall.name] = hall
        }
    }
    
    public func addHall(_ cinemaHallName: String) throws(TheatreError) {
        guard halls[cinemaHallName] == nil else { throw TheatreError.cinemaHallAlreadyExists(name: cinemaHallName) }
        
        let newHall = CinemaHall(name: cinemaHallName)
        halls[cinemaHallName] = newHall
    }
    
    public func addSeatsToHall(_ cinemaHallName: String, numberOfRows: Int, numberOfSeatsPerRow: Int, type: Seat.SeatType) throws(TheatreError) {
        guard halls[cinemaHallName] != nil else { throw TheatreError.cinemaHallNotFound(name: cinemaHallName) }
        halls[cinemaHallName]!.addSeats(numberOfRows: numberOfRows, numberOfSeatsPerRow: numberOfSeatsPerRow, type: type)
    }
    
    public func getCinemaHalls() -> [CinemaHall] {
        halls.values.sorted { $0.name < $1.name }
    }
    
    public func changeSeatType(inHall cinemaHallName: String, row: String, seatNumber: Int, type: Seat.SeatType) throws(TheatreError) {
        guard halls[cinemaHallName] != nil else { throw TheatreError.cinemaHallNotFound(name: cinemaHallName) }
        try halls[cinemaHallName]!.changeSeatType(row: row, seatNumber: seatNumber, to: type)
    }
    
    public func removeSeatInHall(_ cinemaHallName: String, row: String, seatNumber: Int) throws(TheatreError) {
        guard halls[cinemaHallName] != nil else { throw TheatreError.cinemaHallNotFound(name: cinemaHallName) }
        try halls[cinemaHallName]!.removeSeat(row: row, seatNumber: seatNumber)
    }

    public func removeHall(_ cinemaHallName: String) throws(TheatreError) {
        if halls.removeValue(forKey: cinemaHallName) == nil {
            throw TheatreError.cinemaHallNotFound(name: cinemaHallName)
        }
    }
    
    public func setId(_ id: Int64) {
        if self.id == nil { self.id = id }
    }
    
    public subscript(cinemaHallName: String) -> CinemaHall? {
        halls[cinemaHallName]
    }
}
