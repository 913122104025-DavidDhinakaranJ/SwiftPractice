import SQLite
import Models
import Errors

extension SQLiteRepository: TheatreRepository {
    public func add(theatre: Theatre) throws(RepoError) {
        guard theatre.id == nil else { throw RepoError.alreadyExists }
        
        do {
            try db.transaction {
                let insertTheatre = TheatresTable.table.insert(
                    TheatresTable.theatreName <- theatre.name,
                    TheatresTable.address <- theatre.address
                )
                
                let theatreId = try db.run(insertTheatre)
                theatre.setId(theatreId)

                try saveCinemaHalls(cinemaHalls: theatre.getCinemaHalls(), theatreId: theatreId)
            }
        } catch let error as SQLite.Result {
            switch error {
            case .error(_, let code, _):
                if code == ErrorCode.SQLITE_CONSTRAINT_UNIQUE {
                    throw RepoError.alreadyExists
                }
                throw RepoError.dbFailure
            default:
                throw RepoError.dbFailure
            }
        } catch {
            throw RepoError.dbFailure
        }
    }
    
    public func update(theatre: Theatre) throws(RepoError) {
        guard let theatreId = theatre.id else { throw RepoError.notFound }
        
        do {
            try db.transaction {
                let insertTheatre = TheatresTable.table.filter(TheatresTable.id == theatreId).update(
                    TheatresTable.theatreName <- theatre.name,
                    TheatresTable.address <- theatre.address
                )
                
                let rowsUpdated = try db.run(insertTheatre)
                
                if rowsUpdated == 0 { throw RepoError.notFound }
                
                try saveCinemaHalls(cinemaHalls: theatre.getCinemaHalls(), theatreId: theatreId)
            }
        } catch let error as RepoError {
            throw error
        } catch {
            throw RepoError.dbFailure
        }
    }
    
    public func remove(theatre: Theatre) throws(RepoError) {
        guard let theatreId = theatre.id else { throw RepoError.notFound }
        
        do {
            try db.transaction {
                let deleteTheatre = TheatresTable.table.filter(TheatresTable.id == theatreId).delete()
                let rowsDeleted = try db.run(deleteTheatre)
                
                if rowsDeleted == 0 { throw RepoError.notFound }
            }
        } catch let error as RepoError {
            throw error
        } catch {
            print(error)
            throw RepoError.dbFailure
        }
    }
    
    public func getAll() -> [Theatre] {
        return try! db.prepare(TheatresTable.table).map(makeTheatre)
    }
    
    private func saveCinemaHalls(cinemaHalls: [CinemaHall], theatreId: Int64) throws {
        let deleteOldCinemaHalls = CinemaHallsTable.table.filter(CinemaHallsTable.theatreId == theatreId).delete()
        try db.run(deleteOldCinemaHalls)
        
        for cinemaHall in cinemaHalls {
            let insertCinemaHall = CinemaHallsTable.table.insert(
                CinemaHallsTable.theatreId <- theatreId,
                CinemaHallsTable.cinemaHallName <- cinemaHall.name,
            )
            let cinemaHallId = try db.run(insertCinemaHall)
            try saveSeats(seats: cinemaHall.getSeats(), cinemaHallId: cinemaHallId)
        }
    }
    
    private func saveSeats(seats: [Seat], cinemaHallId: Int64) throws {
        for seat in seats {
            let insertSeat = SeatsTable.table.insert(
                SeatsTable.cinemaHallId <- cinemaHallId,
                SeatsTable.row <- seat.row,
                SeatsTable.seatNumber <- seat.seatNumber,
                SeatsTable.type <- SeatTypeMapper.toString(seat.type)
            )
            try db.run(insertSeat)
        }
    }
}
