import Models
import Repositories

public struct ManageAdminControllerImpl: ManageAdminController {
    private let userRepository: UserRepository
    
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    public func getAllAdmins() -> [Admin] {
        userRepository.getAll(role: .admin) as! [Admin]
    }
    
    public func updateAdmin(_ admin: Admin) {
        userRepository.save(user: admin)
    }
}
