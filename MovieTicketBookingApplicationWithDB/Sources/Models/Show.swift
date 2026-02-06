import Foundation

public final class Show {
    public let id: Int64?
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
        self.id = nil
        self.movie = movie
        self.theatre = theatre
        self.cinemaHall = cinemaHall
        self.startTime = startTime
        self.endTime = startTime.addingTimeInterval(TimeInterval((movie.durationInMinutes + breakTime) * 60))
        self.price = price
        
        cinemaHall.getSeats().forEach { seat in
            seats.append(ShowSeat(seat: seat, show: self))
        }
    }
    
    private init(id: Int64, movie: Movie, theatre: Theatre, cinemaHall: CinemaHall, startTime: Date, endTime: Date, price: Double) {
        self.id = id
        self.movie = movie
        self.theatre = theatre
        self.cinemaHall = cinemaHall
        self.startTime = startTime
        self.endTime = endTime
        self.price = price
    }
    
    public static func rehydrate(id: Int64, movie: Movie, theatre: Theatre, cinemaHall: CinemaHall, startTime: Date, endTime: Date, price: Double) -> Show {
        .init(id: id, movie: movie, theatre: theatre, cinemaHall: cinemaHall, startTime: startTime, endTime: endTime, price: price)
    }
    
    public func attach(seats: [ShowSeat]) {
        self.seats = seats
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
