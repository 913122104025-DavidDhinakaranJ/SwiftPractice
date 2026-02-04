import Models

extension Theatre: CustomStringConvertible {
    public var description: String {
        return name
    }
    
    public var detailedDescription: String {
        let allHalls = getCinemaHalls()
        
        let hallList = allHalls.isEmpty ? "No halls configured." : allHalls.map { "  • \($0.description)" }.joined(separator: "\n")
        
        return """
        🏢 THEATRE DASHBOARD
        ================================
        Name:    \(name)
        Address: \(address)
        Screens: \(allHalls.count)
        
        List of Halls:
        \(hallList)
        ================================
        """
    }
}
