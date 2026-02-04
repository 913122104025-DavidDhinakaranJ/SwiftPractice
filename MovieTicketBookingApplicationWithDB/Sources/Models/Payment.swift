import Foundation

public final class Payment {
    private enum PaymentStatus {
        case initiated, success, failed, refunded
    }
        
    public private(set) var amount: Double = 0.0
    private var status: PaymentStatus = .initiated
    public private(set) var paymentDate: Date?
    
    public init() {}

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
