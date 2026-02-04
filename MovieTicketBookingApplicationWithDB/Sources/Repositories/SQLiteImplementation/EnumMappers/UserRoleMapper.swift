import Models

enum UserRoleMapper: StringEnumMapper {
    static var mappings: [User.Role : String] {[
        .admin: "Admin",
        .customer: "Customer"
    ]}
}
