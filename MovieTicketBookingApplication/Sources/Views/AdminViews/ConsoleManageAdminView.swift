import AuthLib
import Contexts
import Controllers
import Models
import Utils

struct ConsoleManageAdminView {
    private enum AdminManageOption: String, CaseIterable, CustomStringConvertible {
        case addAdmin = "Add Admin"
        case viewAdmins = "View Admins"
        case managePrivileges = "Manage Privileges"
        case blockAdmin = "Block Admin"
        case unblockAdmin = "Unblock Admin"
        case back = "Back"
        
        var description: String { rawValue }
    }
    
    private let inputReader = ConsoleInputUtil()
    private let appContext = ApplicationContext.getApplicationContext()
    private let manageAdminController: ManageAdminController
    
    private var running = false
    
    init(manageAdminController: ManageAdminController) {
        self.manageAdminController = manageAdminController
    }
    
    mutating func runView() {
        let options: [AdminManageOption] = [.addAdmin, .viewAdmins, .back]
        running = true
        
        while running {
            let selectedOption: AdminManageOption = inputReader.readMenuOption(options)
            
            switch selectedOption {
            case .addAdmin: handleAddAdmin()
            case .viewAdmins: handleViewAdmins()
            case .back: handleBack()
            default : fatalError("Unhandled case")
            }
        }
    }
    
    private func handleAddAdmin() {
        let authView = ConsoleAuthView(authController: AuthControllerImpl(userRepository: appContext.getUserRepository(), factory: appContext.getAdminFactory()))
        authView.handleRegistration()
    }
    
    private func handleViewAdmins() {
        var selectedAdmin: Admin? = inputReader.readChoiceWithExit(manageAdminController.getAllAdmins())
        
        while let currentAdmin = selectedAdmin {
            print(currentAdmin.detailedDescription)
            
            let options: [AdminManageOption] = [.managePrivileges, (currentAdmin.isBlocked ? .unblockAdmin : .blockAdmin), .back]
            let selectedSubOption: AdminManageOption = inputReader.readMenuOption(options)
            
            switch selectedSubOption {
            case .managePrivileges: handleManagePrivileges(currentAdmin)
            case .blockAdmin: handleBlockAdmin(currentAdmin)
            case .unblockAdmin: handleUnblockAdmin(currentAdmin)
            case .back:
                manageAdminController.updateAdmin(selectedAdmin!)
                selectedAdmin = nil
            default : fatalError("Unhandled case")
            }
        }
    }
    
    private func handleManagePrivileges(_ admin: Admin) {
        let nonExistingPrivileges = Set(Admin.Privilege.allCases).subtracting(admin.privileges)
        if !nonExistingPrivileges.isEmpty {
            inputReader.readMultipleChoices(mainPrompt: "Grant Privileges", nonExistingPrivileges).forEach { privilege in
                admin.grant(privilege)
            }
        }
        
        let existingPrivileges = admin.privileges
        if !existingPrivileges.isEmpty {
            inputReader.readMultipleChoices(mainPrompt: "Revoke Privileges", existingPrivileges).forEach { privilege in
                admin.revoke(privilege)
            }
        }
    }
    
    private func handleBlockAdmin(_ admin: Admin) {
        admin.block()
    }
    
    private func handleUnblockAdmin(_ admin: Admin) {
        admin.unblock()
    }
    
    private mutating func handleBack() {
        running = false
    }
}
