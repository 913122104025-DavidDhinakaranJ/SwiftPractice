import Errors

public struct Theatre {
    nonisolated(unsafe) private static var idCounter: Int = 0
    private var hallIdCounter: Int = 0
    
    public let theatreId: String
    public let name: String
    public let address: String
    public private(set) var halls: [CinemaHall] = []
    
    public init(name: String, address: String) {
        Self.idCounter += 1
        self.theatreId = "THEATRE-\(Self.idCounter)"
        self.name = name
        self.address = address
    }
    
    @discardableResult
    public mutating func addHall(_ cinemaHallName: String) throws(CinemaHallError) -> CinemaHall {
        if halls.contains(where: { $0.name == cinemaHallName }) { throw CinemaHallError.nameAlreadyExists }
        
        hallIdCounter += 1
        let hallId = "HALL_\(theatreId)_\(hallIdCounter)"
        let newHall = CinemaHall(hallId: hallId, name: cinemaHallName)
        halls.append(newHall)
        
        return newHall
    }
    
    public mutating func removeHall(_ cinemaHallName: String) {
        halls.removeAll { $0.name == cinemaHallName }
    }
}
