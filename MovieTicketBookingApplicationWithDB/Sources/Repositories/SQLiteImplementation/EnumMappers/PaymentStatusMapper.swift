import Models

enum PaymentStatusMapper: StringEnumMapper {
    static var mappings: [Payment.PaymentStatus : String] {[
        .failed: "Failed",
        .initiated: "Initiated",
        .refunded: "Refunded",
        .success: "Success"
    ]}
}
