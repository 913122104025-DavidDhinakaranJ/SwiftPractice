import Models

public protocol ManageCustomerController {
    func getAllCustomers() -> [Customer]
    func updateCustomer(_ customer: Customer)
}
