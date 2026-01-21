public class BankAccount {
    private var balance: Double = 0.0
    
    public func deposit(_ amount: Double) {
        guard amount > 0 else { return }
        balance += amount
    }
    
    public func withdraw(_ amount: Double) -> Bool {
        guard amount > 0 else { return false }
        guard amount <= balance else { return false }
        balance -= amount
        return true
    }
    
    public func getBalance() -> Double {
        return balance
    }
}

var account = BankAccount()
account.deposit(100.0)
account.withdraw(50.0)

account.getBalance()
