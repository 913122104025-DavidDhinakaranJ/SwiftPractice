import Models

extension Booking: CustomStringConvertible {
    public var description: String {
        return "\(show) [\(status)]"
    }
    
    public var detailedDescription: String {
        let statusSymbol = switch status {
        case .confirmed: "✅ Confirmed"
        case .cancelled: "❌ Cancelled"
        case .pending:   "⏳ Pending"
        }

        let seatList = seats.map { $0.seat.description }.joined(separator: ", ")
        
        return """
        🎟️ BOOKING RECEIPT
        ================================
        Status:      \(statusSymbol)
        Booked On:   \(bookingDate.displayDateTime)
        
        🎬 MOVIE DETAILS
        Movie:       \(show.movie.title)
        Rating:      \(show.movie.rating)
        Theatre:     \(show.theatre.name)
        Screen:      \(show.cinemaHall.name)
        Time:        \(show.startTime.displayDateTime)
        
        💰 PAYMENT
        Seats:       \(seatList) (\(seats.count) tickets)
        Total Price: $\(String(format: "%.2f", totalPrice))
        ================================
        """
    }
}
