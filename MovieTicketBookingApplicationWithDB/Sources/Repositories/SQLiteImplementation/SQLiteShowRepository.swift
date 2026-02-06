import SQLite
import Models
import Errors
import Foundation

extension SQLiteRepository: ShowRepository {
    public func add(show: Show) throws(RepoError) {
        guard show.id == nil, !isShowConflict(show) else { throw RepoError.alreadyExists }
        
        do {
            try db.transaction {
                let insertShow = ShowsTable.table.insert(
                    ShowsTable.movieId <- show.movie.id!,
                    ShowsTable.cinemaHallId <- show.cinemaHall.id!,
                    ShowsTable.startTime <- show.startTime,
                    ShowsTable.endTime <- show.endTime,
                    ShowsTable.price <- show.price
                )
                
                let showId = try db.run(insertShow)
                try saveShowSeats(showSeats: show.seats, showId: showId)
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
    
    public func update(show: Show) throws(RepoError) {
        do {
            try db.transaction {
                let updateShow = ShowsTable.table.filter(ShowsTable.id == show.id!).update(
                    ShowsTable.movieId <- show.movie.id!,
                    ShowsTable.cinemaHallId <- show.cinemaHall.id!,
                    ShowsTable.startTime <- show.startTime,
                    ShowsTable.endTime <- show.endTime,
                    ShowsTable.price <- show.price
                )
                
                let updatedRows = try db.run(updateShow)
                if updatedRows == 0 { throw RepoError.notFound }
                try saveShowSeats(showSeats: show.seats, showId: show.id!)
            }
        } catch let error as RepoError {
            throw error
        } catch {
            throw RepoError.dbFailure
        }
    }
    
    public func delete(show: Show) throws(RepoError) {
        do {
            try db.transaction {
                let deleteShow = ShowsTable.table.filter(ShowsTable.id == show.id!).delete()
                let deletedRows = try db.run(deleteShow)
                if deletedRows == 0 { throw RepoError.notFound }
            }
        } catch let error as RepoError {
            throw error
        } catch {
            throw RepoError.dbFailure
        }
    }
    
    public func getAll() -> [Show] {
        return try! db.prepare(ShowsTable.table).map(makeShow)
    }
    
    public func getFutureShows(forMovie movie: Movie) -> [Show] {
        return try! db.prepare(ShowsTable.table.filter(ShowsTable.movieId == movie.id! && ShowsTable.startTime > Date())).map(makeShow)
    }
    
    private func saveShowSeats(showSeats: [ShowSeat], showId: Int64) throws {
        for showSeat in showSeats {
            if let showSeatId = showSeat.id {
                let update = ShowSeatsTable.table.filter(ShowSeatsTable.id == showSeatId).update(
                    ShowSeatsTable.status <- ShowSeatStatusMapper.toString(showSeat.status),
                    ShowSeatsTable.showId <- showId,
                    ShowSeatsTable.seatId <- showSeat.seat.id!
                )
                
                let rowsUpdated = try db.run(update)
                if rowsUpdated == 0 {
                    throw RepoError.notFound
                }
            } else {
                let insert = ShowSeatsTable.table.insert(
                    ShowSeatsTable.showId <- showId,
                    ShowSeatsTable.seatId <- showSeat.seat.id!,
                    ShowSeatsTable.status <- ShowSeatStatusMapper.toString(showSeat.status)
                )
                
                try db.run(insert)
            }
        }
    }
    
    func isShowConflict(_ show: Show) -> Bool {
        let locationMatch = ShowsTable.cinemaHallId == show.cinemaHall.id ?? -1
        let timeOverlap = ShowsTable.startTime < show.endTime &&
                          ShowsTable.endTime > show.startTime
        let selfExclusion = ShowsTable.id != (show.id ?? -1)
        
        let query = ShowsTable.table.filter(
            locationMatch &&
            timeOverlap &&
            selfExclusion
        )
        
        let count = try! db.scalar(query.count)
        return count > 0
    }
}
