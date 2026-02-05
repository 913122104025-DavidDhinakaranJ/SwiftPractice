import Models

enum SeatTypeMapper: StringEnumMapper {
    static var mappings: [Seat.SeatType : String] {[
        .premium: "Premium",
        .regular: "Regular",
        .vip: "Vip"
    ]}
}

