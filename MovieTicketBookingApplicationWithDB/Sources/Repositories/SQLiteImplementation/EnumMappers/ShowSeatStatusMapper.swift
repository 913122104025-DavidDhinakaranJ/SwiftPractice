import Models

enum ShowSeatStatusMapper: StringEnumMapper {
    static var mappings: [ShowSeat.Status : String] {[
        .available: "Available",
        .booked: "Booked",
    ]}
}
