import Foundation

public final class Payment {
    private enum PaymentStatus {
        case initiated, success, failed, refunded
    }
    
    nonisolated(unsafe) private static var idCounter: Int = 1000
    
    public let paymentId: String
    public private(set) var amount: Double = 0.0
    private var status: PaymentStatus = .initiated
    public private(set) var paymentDate: Date?
    
    public init() {
        Payment.idCounter += 1
        paymentId = "\(Payment.idCounter)"
    }

    public func update(amount: Double) {
        self.amount = amount
    }
    
    public func updateStatusToSuccess() {
        self.status = .success
        paymentDate = Date()
    }
    
    public func updateStatusToFailed() {
        self.status = .failed
    }
    
    public func updateStatusToRefunded() {
        self.status = .refunded
    }
}
