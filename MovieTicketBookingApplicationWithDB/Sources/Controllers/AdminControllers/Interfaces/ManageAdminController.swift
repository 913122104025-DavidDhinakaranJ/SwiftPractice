import Models

public protocol ManageAdminController {
    func getAllAdmins() -> [Admin]
    func updateAdmin(_ admin: Admin)
}
