import Foundation

public final class Payment {
    public enum PaymentStatus {
        case initiated, success, failed, refunded
    }
        
    public private(set) var amount: Double = 0.0
    public private(set) var status: PaymentStatus = .initiated
    public private(set) var paymentDate: Date?
    
    public init() {}
    
    private init(amount: Double, paymentStatus: PaymentStatus, paymentDate: Date?) {
        self.amount = amount
        self.status = paymentStatus
        self.paymentDate = paymentDate
    }
    
    public static func rehydrate(amount: Double, paymentStatus: PaymentStatus, paymentDate: Date?) -> Payment {
        .init(amount: amount, paymentStatus: paymentStatus, paymentDate: paymentDate)
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
