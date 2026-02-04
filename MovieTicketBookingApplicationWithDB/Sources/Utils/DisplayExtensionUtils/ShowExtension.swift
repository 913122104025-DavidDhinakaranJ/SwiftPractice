import Models

extension Show: CustomStringConvertible {
    public var description: String {
        return "\(movie.title) @ \(startTime.displayDateTime) in \(theatre.name)"
    }
    
    public var detailedDescription: String {
        let total = seats.count
        let available = getAvailableSeats().count
        let booked = total - available
        
        let timeStatus: String
        if isShowStarted {
            timeStatus = "🔴 In Progress / Finished"
        } else if available == 0 {
            timeStatus = "⚠️ SOLD OUT"
        } else {
            timeStatus = "🟢 Booking Open"
        }
        
        return """
        🎟️ SHOWTIME SUMMARY
        ================================
        Movie:    \(movie.title) (\(movie.rating))
        Venue:    \(theatre.name), \(cinemaHall.name)
        Time:     \(startTime.displayDateTime) to \(endTime.displayDateTime)
        Status:   \(timeStatus)
        Base $$:  $\(price)
        
        📊 OCCUPANCY
        Available: \(available)
        Booked:    \(booked)
        Total:     \(total)
        ================================
        """
    }
}
