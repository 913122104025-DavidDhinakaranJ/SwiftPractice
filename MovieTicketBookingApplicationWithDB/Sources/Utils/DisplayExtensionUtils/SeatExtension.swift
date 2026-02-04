import Models

extension Seat: CustomStringConvertible {
    public var description: String {
        return "\(row)\(seatNumber) (\(type))"
    }
    
    public var detailedDescription: String {
        return "💺 \(row)\(seatNumber) | Type: \(type) (x\(type.rawValue))"
    }
}
