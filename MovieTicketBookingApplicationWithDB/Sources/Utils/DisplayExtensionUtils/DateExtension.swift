import Foundation

extension Date {
    private static let dateTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy, h:mm a"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    private static let dateOnlyFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
        
    public var displayDateTime: String {
        return Date.dateTimeFormatter.string(from: self)
    }
    
    public var displayDate: String {
        return Date.dateOnlyFormatter.string(from: self)
    }
}
