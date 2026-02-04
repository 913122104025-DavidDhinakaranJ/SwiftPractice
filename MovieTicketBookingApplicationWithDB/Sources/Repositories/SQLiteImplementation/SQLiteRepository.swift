import SQLite

public final class SQLiteRepository: @unchecked Sendable {
    public static let shared = SQLiteRepository()
    let db: Connection
    
    private init() {
        do {
            db = try Connection("db.sqlite3")
            try db.run("PRAGMA foreign_keys = ON")
            try createTables()
        } catch {
            fatalError("Could not open database.")
        }
    }
    
    private func createTables() throws {
        try createUserTable()
        try createMovieTable()
        try createMovieGenreTable()
        try createMovieLanguageTable()
        try createTheatreTable()
        try createCinemaHallTable()
        try createSeatTable()
        try createShowTable()
        try createShowSeatTable()
        try createPaymentTable()
        try createAdminPrivilegeTable()
        try createBookingTable()
        try createBookingSeatTable()
    }
    
    private func createUserTable() throws {
        try db.run(UsersTable.table.create(ifNotExists: true) { t in
            t.column(UsersTable.id, primaryKey: .autoincrement)
            t.column(UsersTable.username, unique: true)
            t.column(UsersTable.password)
            t.column(UsersTable.role)
            t.column(UsersTable.isBlocked)
        })
    }
    
    private func createAdminPrivilegeTable() throws {
        try db.run(AdminPrivilegesTable.table.create(ifNotExists: true) { t in
            t.column(AdminPrivilegesTable.adminId)
            t.column(AdminPrivilegesTable.privilege)
            
            t.primaryKey(AdminPrivilegesTable.adminId, AdminPrivilegesTable.privilege)
            t.foreignKey(AdminPrivilegesTable.adminId, references: UsersTable.table, UsersTable.id, delete: .cascade)
        })
    }
    
    private func createBookingTable() throws {
        try db.run(BookingsTable.table.create(ifNotExists: true) { t in
            t.column(BookingsTable.id, primaryKey: .autoincrement)
            t.column(BookingsTable.customerId)
            t.column(BookingsTable.bookingDate)
            t.column(BookingsTable.status)
            t.column(BookingsTable.showId)
            t.column(BookingsTable.totalPrice)
            t.column(BookingsTable.paymentId)
            
            t.foreignKey(BookingsTable.customerId, references: UsersTable.table, UsersTable.id, delete: .cascade)
            t.foreignKey(BookingsTable.showId, references: ShowsTable.table, ShowsTable.id, delete: .cascade)
            t.foreignKey(BookingsTable.paymentId, references: PaymentsTable.table, PaymentsTable.id, delete: .cascade)
        })
    }
    
    private func createBookingSeatTable() throws {
        try db.run(BookingSeatsTable.table.create(ifNotExists: true) { t in
            t.column(BookingSeatsTable.bookingId)
            t.column(BookingSeatsTable.showSeatId)
            
            t.primaryKey(BookingSeatsTable.bookingId, BookingSeatsTable.showSeatId)
            t.foreignKey(BookingSeatsTable.bookingId, references: BookingsTable.table, BookingsTable.id)
            t.foreignKey(BookingSeatsTable.showSeatId, references: ShowSeatsTable.table, ShowSeatsTable.id)
        })
    }
    
    private func createPaymentTable() throws {
        try db.run(PaymentsTable.table.create(ifNotExists: true) { t in
            t.column(PaymentsTable.id, primaryKey: .autoincrement)
            t.column(PaymentsTable.amount)
            t.column(PaymentsTable.status)
            t.column(PaymentsTable.paymentDate)
        })
    }
    
    private func createMovieTable() throws {
        try db.run(MoviesTable.table.create(ifNotExists: true) { t in
            t.column(MoviesTable.id, primaryKey: .autoincrement)
            t.column(MoviesTable.name, unique: true)
            t.column(MoviesTable.duration)
            t.column(MoviesTable.rating)
            t.column(MoviesTable.releaseDate)
        })
    }
    
    private func createMovieGenreTable() throws {
        try db.run(MovieGenresTable.table.create(ifNotExists: true) { t in
            t.column(MovieGenresTable.movieId)
            t.column(MovieGenresTable.genre)
            
            t.primaryKey(MovieGenresTable.movieId, MovieGenresTable.genre)
            t.foreignKey(MovieGenresTable.movieId, references: MoviesTable.table, MoviesTable.id, delete: .cascade)
        })
    }
    
    private func createMovieLanguageTable() throws {
        try db.run(MovieLanguagesTable.table.create(ifNotExists: true) { t in
            t.column(MovieLanguagesTable.movieId)
            t.column(MovieLanguagesTable.language)
            
            t.primaryKey(MovieLanguagesTable.movieId, MovieLanguagesTable.language)
            t.foreignKey(MovieLanguagesTable.movieId, references: MoviesTable.table, MoviesTable.id, delete: .cascade)
        })
    }
    
    private func createTheatreTable() throws {
        try db.run(TheatresTable.table.create(ifNotExists: true) { t in
            t.column(TheatresTable.id, primaryKey: .autoincrement)
            t.column(TheatresTable.theatreName, unique: true)
            t.column(TheatresTable.address)
        })
    }
    
    private func createCinemaHallTable() throws {
        try db.run(CinemaHallsTable.table.create(ifNotExists: true) { t in
            t.column(CinemaHallsTable.id, primaryKey: .autoincrement)
            t.column(CinemaHallsTable.cinemaHallName)
            t.column(CinemaHallsTable.theatreId)
            
            t.foreignKey(CinemaHallsTable.theatreId, references: TheatresTable.table, TheatresTable.id, delete: .cascade)
            t.unique(CinemaHallsTable.cinemaHallName, CinemaHallsTable.theatreId)
        })
    }
    
    private func createSeatTable() throws {
        try db.run(SeatsTable.table.create(ifNotExists: true) { t in
            t.column(SeatsTable.id, primaryKey: .autoincrement)
            t.column(SeatsTable.row)
            t.column(SeatsTable.seatNumber)
            t.column(SeatsTable.type)
            t.column(SeatsTable.cinemaHallId)
            
            t.foreignKey(SeatsTable.cinemaHallId, references: CinemaHallsTable.table, CinemaHallsTable.id, delete: .cascade)
            t.unique(SeatsTable.row, SeatsTable.seatNumber, SeatsTable.cinemaHallId)
        })
    }
    
    private func createShowTable() throws {
        try db.run(ShowsTable.table.create(ifNotExists: true) { t in
            t.column(ShowsTable.id, primaryKey: .autoincrement)
            t.column(ShowsTable.movieId)
            t.column(ShowsTable.cinemaHallId)
            t.column(ShowsTable.startTime)
            t.column(ShowsTable.endTime)
            t.column(ShowsTable.price)
            
            t.foreignKey(ShowsTable.movieId, references: MoviesTable.table, MoviesTable.id, delete: .cascade)
            t.foreignKey(ShowsTable.cinemaHallId, references: CinemaHallsTable.table, CinemaHallsTable.id, delete: .cascade)
        })
    }
    
    private func createShowSeatTable() throws {
        try db.run(ShowSeatsTable.table.create(ifNotExists: true) { t in
            t.column(ShowSeatsTable.id, primaryKey: .autoincrement)
            t.column(ShowSeatsTable.showId)
            t.column(ShowSeatsTable.seatId)
            t.column(ShowSeatsTable.status)
            
            t.foreignKey(ShowSeatsTable.showId, references: ShowsTable.table, ShowsTable.id, delete: .cascade)
            t.foreignKey(ShowSeatsTable.seatId, references: SeatsTable.table, SeatsTable.id, delete: .cascade)
            t.unique(ShowSeatsTable.showId, ShowSeatsTable.seatId)
        })
    }
}
