import Models
import Utils

struct ConsolePaymentView {
    private let inputReader = ConsoleInputUtil()
    private var payment: Payment
    
    init(payment: Payment) {
        self.payment = payment
    }
    
    mutating func handlePayment(amount: Double) -> Bool {
        print("Amount to Pay: \(amount)")
        if inputReader.readBool(prompt: "Do you want to pay?") {
            print("Payment successful!")
            payment.update(amount: amount)
            payment.updateStatusToSuccess()
            return true
        } else {
            print("Payment cancelled.")
            payment.updateStatusToFailed()
            return false
        }
    }
}
