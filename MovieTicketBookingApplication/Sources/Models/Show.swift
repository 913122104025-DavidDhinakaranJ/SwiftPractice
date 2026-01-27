import Foundation

public final class Show {
    nonisolated(unsafe) private static var idCounter: Int = 0
    
    public let showId: String
    public let movie: Movie
    public let theatre: Theatre
    public let cinemaHall: CinemaHall
    public private(set) var startTime: Date
    public private(set) var endTime: Date
    public private(set) var seats: [ShowSeat] = []
    public let price: Double
    
    public init(movie: Movie, theatre: Theatre, cinemaHall: CinemaHall, startTime: Date, breakTime: Int, price: Double) {
        Self.idCounter += 1
        self.showId = "Show-\(Self.idCounter)"
        self.movie = movie
        self.theatre = theatre
        self.cinemaHall = cinemaHall
        self.startTime = startTime
        self.endTime = startTime.addingTimeInterval(TimeInterval(movie.durationInMinutes) + TimeInterval(breakTime))
        self.price = price
        
        cinemaHall.seats.forEach { seat in
            seats.append(ShowSeat(showSeatId: "\(showId)_\(seat.seatId)", seat: seat, show: self))
        }
    }
    
    public func setTime(startTime: Date, breakTime: Int) {
        self.startTime = startTime
        self.endTime = startTime.addingTimeInterval(TimeInterval(movie.durationInMinutes) + TimeInterval(breakTime))
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
