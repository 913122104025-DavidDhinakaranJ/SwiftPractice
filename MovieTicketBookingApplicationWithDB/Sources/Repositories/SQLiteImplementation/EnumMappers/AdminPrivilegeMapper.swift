import Models

enum AdminPrivilegeMapper: StringEnumMapper {
    static var mappings: [Admin.Privilege : String] {[
        .admin: "admin",
        .customer: "customer",
        .movie: "movie",
        .show: "show",
        .theatre: "theatre"
    ]}
}
