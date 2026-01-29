import Foundation

public final class Show {
    public let showId: String
    public let movie: Movie
    public let theatre: Theatre
    public let cinemaHall: CinemaHall
    public private(set) var startTime: Date
    public private(set) var endTime: Date
    public private(set) var seats: [ShowSeat] = []
    public let price: Double
    public var isShowStarted: Bool { startTime <= Date() }
    public var isSeatsAvailable: Bool { seats.contains(where: { $0.isAvailable }) }
    
    public init(movie: Movie, theatre: Theatre, cinemaHall: CinemaHall, startTime: Date, breakTime: Int, price: Double) {
        self.showId = "Show-\(UUID().uuidString)"
        self.movie = movie
        self.theatre = theatre
        self.cinemaHall = cinemaHall
        self.startTime = startTime
        self.endTime = startTime.addingTimeInterval(TimeInterval(movie.durationInMinutes) + TimeInterval(breakTime))
        self.price = price
        
        cinemaHall.seats.values.forEach { seat in
            seats.append(ShowSeat(seat: seat, show: self))
        }
    }
    
    public func setTime(startTime: Date, breakTime: Int) {
        self.startTime = startTime
        self.endTime = startTime.addingTimeInterval(TimeInterval((movie.durationInMinutes + breakTime) * 60))
    }
    
    public func getAvailableSeats() -> [ShowSeat] {
        var availableSeats: [ShowSeat] = []
        
        seats.forEach { seat in
            if seat.isAvailable {
                availableSeats.append(seat)
            }
        }
        
        return availableSeats
    }
}
