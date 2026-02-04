import Models

extension Customer {
    public var detailedDescription: String {
        let status = isBlocked ? "🚫 Blocked" : "✅ Active"
        
        return """
        👤 CUSTOMER PROFILE
        --------------------------------
        Username:    \(username)
        Role:        Customer
        Status:      \(status)
        Total Bookings: \(bookings.count)
        --------------------------------
        """
    }
}
