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
            let customers = manageCustomerController.getAllCustomers()
            
            guard !customers.isEmpty else {
                print("No customers to manage.")
                running = false
                continue
            }
            
            var selectedCustomer: Customer? = inputReader.readChoiceWithExit(manageCustomerController.getAllCustomers())
            
            if selectedCustomer == nil {
                running = false
            }
            
            while let currentCustomer = selectedCustomer {
                print(currentCustomer.detailedDescription)
                
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
}

