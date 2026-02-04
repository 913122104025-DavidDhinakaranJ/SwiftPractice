import Models
import Repositories

public struct CustomerControllerImpl: CustomerController {
    private let userRepository: UserRepository
    
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    public func save(customer: Customer) {
        userRepository.save(user: customer)
    }
}
