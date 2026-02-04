public enum TheatreError: Error {
    case cinemaHallAlreadyExists(name: String)
    case cinemaHallNotFound(name: String)
    case seatNotFound(row: String, seatNumber: Int)
}
