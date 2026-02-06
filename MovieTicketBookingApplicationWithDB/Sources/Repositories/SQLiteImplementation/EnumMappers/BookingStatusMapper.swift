import Models

enum BookingStatusMapper: StringEnumMapper {
    static var mappings: [Booking.Status : String] {[
        .cancelled: "cancelled",
        .confirmed: "confirmed",
        .pending: "pending"
    ]}
}
