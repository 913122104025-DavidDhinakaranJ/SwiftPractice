import Models

extension CinemaHall: CustomStringConvertible {
    public var description: String {
        return name
    }
    
    public var detailedDescription: String {
        let allSeats = getSeats()
        let total = allSeats.count
        
        let vipCount = allSeats.filter { $0.type == .vip }.count
        let premiumCount = allSeats.filter { $0.type == .premium }.count
        let regularCount = allSeats.filter { $0.type == .regular }.count
        
        let rows = Set(allSeats.map { $0.row }).sorted()
        let rowRange = rows.isEmpty ? "None" : "\(rows.first!) - \(rows.last!)"
        
        return """
        🎬 CINEMA HALL REPORT: \(name)
        --------------------------------
        Total Capacity: \(total)
        Rows:           \(rowRange)
        
        📊 Seat Breakdown:
        - VIP:      \(vipCount)
        - Premium:  \(premiumCount)
        - Regular:  \(regularCount)
        --------------------------------
        """
    }
}
