import SQLite
import Foundation

enum PaymentsTable {
    static let table = Table("payments")
    
    static let id = Expression<Int64>("id")
    static let amount = Expression<Double>("amount")
    static let status = Expression<String>("status")
    static let paymentDate = Expression<Date?>("payment_date")
}
