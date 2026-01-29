import Errors

public struct Theatre {
    public let name: String
    public let address: String
    public private(set) var halls: [String : CinemaHall] = [:]
    
    public init(name: String, address: String) {
        self.name = name
        self.address = address
    }
    
    public mutating func addHall(_ cinemaHallName: String) throws(TheatreError) {
        if halls[cinemaHallName] != nil { throw TheatreError.cinemaHallAlreadyExists }
        
        let newHall = CinemaHall(name: cinemaHallName)
        halls[cinemaHallName] = newHall
    }

    public mutating func removeHall(_ cinemaHallName: String) throws(TheatreError) {
        if halls.removeValue(forKey: cinemaHallName) == nil {
            throw TheatreError.cinemaHallNotFound
        }
    }
}
