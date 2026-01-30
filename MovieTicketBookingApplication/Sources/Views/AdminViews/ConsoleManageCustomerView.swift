import Controllers
import Models
import Utils

struct ConsoleManageCustomerView {
    private enum CustomerManageOption: String, CaseIterable, CustomStringConvertible {
        case blockCustomer = "Block Customer"
        case unblockCustomer = "Unblock Customer"
        case back = "Back"
        
        var description: String { rawValue }
    }
    
    private let inputReader = ConsoleInputUtil()
    private let manageCustomerController: ManageCustomerController
    
    private var running = false
    
    init(manageCustomerController: ManageCustomerController) {
        self.manageCustomerController = manageCustomerController
    }
    
    mutating func runView() {
        running = true
        while running {
            var selectedCustomer: Customer? = inputReader.readChoiceWithExit(manageCustomerController.getAllCustomers()) { customer in
                "\(customer.username) (Blocked: \(customer.isBlocked ? "Yes" : "No"))"
            }
            
            while let currentCustomer = selectedCustomer {
                let options: [CustomerManageOption] = [(currentCustomer.isBlocked ? .unblockCustomer : .blockCustomer), .back]
                let selectedSubOption: CustomerManageOption = inputReader.readMenuOption(options)
                
                switch selectedSubOption {
                case .blockCustomer: handleBlockCustomer(currentCustomer)
                case .unblockCustomer: handleUnblockCustomer(currentCustomer)
                case .back:
                    manageCustomerController.updateCustomer(selectedCustomer!)
                    selectedCustomer = nil
                }
            }
        }
    }
    
    private func handleBlockCustomer(_ customer: Customer) {
        customer.block()
    }
    
    private func handleUnblockCustomer(_ customer: Customer) {
        customer.unblock()
    }
    
    private mutating func handleBack() {
        running = false
    }
}

