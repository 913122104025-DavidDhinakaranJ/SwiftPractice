struct House {
    private var rooms: [Room]
    init() {
        rooms = []
    }
    mutating func addRoom(room roomName: String) {
        rooms.append(Room(roomName: roomName))
    }
    func getRooms() -> [String] {
        return rooms.map { $0.getRoomName() }
    }
}

struct Room {
    private var roomName: String
    init(roomName: String) {
        self.roomName = roomName
    }
    func getRoomName() -> String {
        return roomName
    }
}

var house = House()
house.addRoom(room: "Living Room")  // Here Room is created inside House. So it doesn't outlive House
