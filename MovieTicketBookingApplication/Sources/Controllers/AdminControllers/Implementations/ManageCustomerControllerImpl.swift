import Models
import Repositories

public struct ManageCustomerControllerImpl: ManageCustomerController {
    private let userRepository: UserRepository
    
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    public func getAllCustomers() -> [Customer] {
        userRepository.getAll(role: .customer) as! [Customer]
    }
    
    public func updateCustomer(_ customer: Customer) {
        userRepository.save(user: customer)
    }
    
}
