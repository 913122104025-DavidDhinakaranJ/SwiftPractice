import Models

extension User: CustomStringConvertible {
    public var description: String {
        "\(username) - \(isBlocked ? "Blocked" : "Active")"
    }
}
