import Models

extension ShowSeat: CustomStringConvertible {
    public var description: String {
        let statusIcon = isAvailable ? "✅" : "❌"
        return "\(seat.row)\(seat.seatNumber) \(statusIcon)"
    }
    
    public var detailedDescription: String {
        let statusText = isAvailable ? "Available" : "Booked"
        
        let finalPrice = show.price * seat.type.rawValue
        
        return """
        💺 SEAT DETAILS
        --------------------------------
        Location:  Row \(seat.row), Seat \(seat.seatNumber)
        Type:      \(seat.type) (x\(seat.type.rawValue))
        Status:    \(statusText)
        Price:     $\(String(format: "%.2f", finalPrice))
        --------------------------------
        """
    }
}
