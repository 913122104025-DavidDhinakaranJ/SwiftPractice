import Models
import SQLite

extension SQLiteRepository {
    func makeUser(from row: Row) -> User {
        let role = UserRoleMapper.toEnumCase(row[UsersTable.role])
        
        return switch role {
        case .admin: makeAdmin(from: row)
        case .customer: makeCustomer(from: row)
        }
    }
    
    func makeCustomer(from row: Row) -> Customer {
        let customer = Customer.rehydrate(username: row[UsersTable.username],
                                          passwordHash: row[UsersTable.password],
                                          isBlocked: row[UsersTable.isBlocked])
        let bookings = getBookings(forCustomerId: row[UsersTable.id], contextCustomer: customer)
        customer.attach(bookings: bookings)
        
        return customer
    }
    
    func makeAdmin(from row: Row) -> Admin {
        let privileges = getPrivileges(forAdminId: row[UsersTable.id])
        let admin = Admin.rehydrate(username: row[UsersTable.username],
                                    password: row[UsersTable.password],
                                    privileges: privileges,
                                    isBlocked: row[UsersTable.isBlocked])
        
        return admin
    }
    
    func makeMovie(from row: Row) -> Movie {
        let genres = getGenres(forMovieId: row[MoviesTable.id])
        let languages = getLanguages(forMovieId: row[MoviesTable.id])
        let rating = MovieRatingMapper.toEnumCase(row[MoviesTable.rating])
        
        let movie = Movie.rehydrate(title: row[MoviesTable.name],
                                    durationInMinutes: row[MoviesTable.duration],
                                    rating: rating,
                                    releaseDate: row[MoviesTable.releaseDate],
                                    genres: genres,
                                    languages: languages)
        
        return movie
    }
    
    func makeSeat(from row: Row) -> Seat {
        let seatType = SeatTypeMapper.toEnumCase(row[SeatsTable.type])
        let seat = Seat.rehydrate(row: row[SeatsTable.row],
                       seatNumber: row[SeatsTable.seatNumber],
                       type: seatType)
        
        return seat
    }
    
    func makeCinemahall(from row: Row) -> CinemaHall {
        let seats = getSeats(forCinemaHallId: row[CinemaHallsTable.id])
        let cinemaHall = CinemaHall.rehydrate(name: row[CinemaHallsTable.cinemaHallName],
                                              seats: seats)

        return cinemaHall
    }
    
    func makeTheatre(from row: Row) -> Theatre {
        let cinemaHalls = getCinemaHalls(forTheatreId: row[TheatresTable.id])
        let theatre = Theatre.rehydrate(name: row[TheatresTable.theatreName],
                                        address: row[TheatresTable.address],
                                        halls: cinemaHalls)
        
        return theatre
    }
    
    func makeShowSeat(from row: Row, contextShow: Show? = nil) -> ShowSeat {
        let seat = getSeat(forSeatId: row[ShowSeatsTable.seatId])
        let show = contextShow ?? getShow(forShowId: row[ShowSeatsTable.showId])
        let status = ShowSeatStatusMapper.toEnumCase(row[ShowSeatsTable.status])
        
        let showSeat = ShowSeat.rehydrate(seat: seat,
                                          show: show,
                                          status: status)
        
        return showSeat
    }
    
    func makeShow(from row: Row) -> Show {
        let movie = getMovie(forMovieId: row[ShowsTable.movieId])
        let cinemaHall = getCinemaHall(forCinemaHallId: row[ShowsTable.cinemaHallId])
        let theatre = getTheatre(forCinemaHallId: row[ShowsTable.cinemaHallId])
        
        let show = Show.rehydrate(movie: movie,
                                  theatre: theatre,
                                  cinemaHall: cinemaHall,
                                  startTime: row[ShowsTable.startTime],
                                  endTime: row[ShowsTable.endTime],
                                  price: row[ShowsTable.price])
        
        let seats = getShowSeats(forShowId: row[ShowsTable.id], contextShow: show)
        show.attach(seats: seats)
        
        return show
    }
    
    func makePayment(from row: Row) -> Payment {
        let paymentStatus = PaymentStatusMapper.toEnumCase(row[PaymentsTable.status])
        let payment = Payment.rehydrate(amount: row[PaymentsTable.amount],
                                        paymentStatus: paymentStatus,
                                        paymentDate: row[PaymentsTable.paymentDate])
        
        return payment
    }
    
    func makeBooking(from row: Row, contextCustomer: Customer? = nil, contextShow: Show? = nil) -> Booking {
        let customer = contextCustomer ?? getCustomer(forCustomerId: row[BookingsTable.customerId])
        let show = contextShow ?? getShow(forShowId: row[BookingsTable.showId])
        let seats = getShowSeats(forBookingId: row[BookingsTable.id])
        let payment = getPayment(forPaymentId: row[BookingsTable.paymentId])
        
        let booking = Booking.rehydrate(bookingDate: row[BookingsTable.bookingDate],
                                        customer: customer,
                                        show: show,
                                        seats: seats,
                                        totalPrice: row[BookingsTable.totalPrice],
                                        payment: payment)
        
        return booking
    }
    
    func getPrivileges(forAdminId adminId: Int) -> [Admin.Privilege] {
        do {
            return try db.prepare(AdminPrivilegesTable.table.filter(AdminPrivilegesTable.adminId == adminId))
                .map { AdminPrivilegeMapper.toEnumCase($0[AdminPrivilegesTable.privilege]) }
        } catch {
            fatalError("Error in DB")
        }
    }
    
    func getBookings(forCustomerId customerId: Int, contextCustomer: Customer) -> [Booking] {
        do {
            return try db.prepare(BookingsTable.table.filter(BookingsTable.customerId == customerId))
                .map { makeBooking(from: $0, contextCustomer: contextCustomer) }
        } catch {
            fatalError("Error in DB")
        }
    }
    
    func getGenres(forMovieId movieId: Int) -> [Movie.Genre] {
        do {
            return try db.prepare(MovieGenresTable.table.filter(MovieGenresTable.movieId == movieId))
                .map { MovieGenreMapper.toEnumCase($0[MovieGenresTable.genre]) }
        } catch {
            fatalError("Error in DB")
        }
    }
    
    func getLanguages(forMovieId movieId: Int) -> [Movie.Language] {
        do {
            return try db.prepare(MovieLanguagesTable.table.filter(MovieLanguagesTable.movieId == movieId))
                .map { MovieLanguageMapper.toEnumCase($0[MovieLanguagesTable.language]) }
        } catch {
            fatalError("Error in DB")
        }
    }
    
    func getSeats(forCinemaHallId cinemaHallId: Int) -> [Seat] {
        do {
            return try db.prepare(SeatsTable.table.filter(SeatsTable.cinemaHallId == cinemaHallId))
                .map(makeSeat)
        } catch {
            fatalError("Error in DB")
        }
    }
    
    func getCinemaHalls(forTheatreId theatreId: Int) -> [CinemaHall] {
        do {
            return try db.prepare(CinemaHallsTable.table.filter(CinemaHallsTable.theatreId == theatreId))
                .map(makeCinemahall)
        } catch {
            fatalError("Error in DB")
        }
    }
    
    func getMovie(forMovieId movieId: Int) -> Movie {
        do {
            let row = try db.pluck(MoviesTable.table.filter(MoviesTable.id == movieId))!
            return makeMovie(from: row)
        } catch {
            fatalError("Error in DB")
        }
    }
    
    func getTheatre(forCinemaHallId cinemaHallId: Int) -> Theatre {
        do {
            let theatreId = try db.pluck(CinemaHallsTable.table.filter(CinemaHallsTable.id == cinemaHallId))!.get(CinemaHallsTable.theatreId)
            return try db.pluck(TheatresTable.table.filter(TheatresTable.id == theatreId)).map(makeTheatre)!
        } catch {
            fatalError("Error in DB")
        }
    }
    
    func getCinemaHall(forCinemaHallId cinemaHallId: Int) -> CinemaHall {
        do {
            return try db.pluck(CinemaHallsTable.table.filter(CinemaHallsTable.id == cinemaHallId)).map(makeCinemahall)!
        } catch {
            fatalError("Error in DB")
        }
    }
    
    func getShowSeats(forShowId showId: Int, contextShow: Show) -> [ShowSeat] {
        do {
            return try db.prepare(ShowSeatsTable.table.filter(ShowSeatsTable.showId == showId))
                .map { makeShowSeat(from: $0, contextShow: contextShow) }
        } catch {
            fatalError("Error in DB")
        }
    }
    
    func getSeat(forSeatId seatId: Int) -> Seat {
        do {
            return try db.pluck(SeatsTable.table.filter(SeatsTable.id == seatId)).map(makeSeat)!
        } catch {
            fatalError("Error in DB")
        }
    }
    
    func getShow(forShowId showId: Int) -> Show {
        do {
            let row = try db.pluck(ShowsTable.table.filter(ShowsTable.id == showId)).map(makeShow)!
        } catch {
            fatalError("Error in DB")
        }
    }
    
    func getCustomer(forCustomerId customerId: Int) -> Customer {
        do {
            let row = try db.pluck(UsersTable.table.filter(UsersTable.id == customerId)).map(makeCustomer)!
        } catch {
            fatalError("Error in DB")
        }
    }
    
    func getShowSeats(forBookingId bookingId: Int) -> [ShowSeat] {
        do {
            return try db.prepare(BookingsTable.table.filter(BookingSeatsTable.bookingId == bookingId))
                .map { row in
                    let showSeatId = try row.get(BookingSeatsTable.showSeatId)
                    let row = try db.pluck(ShowSeatsTable.table.filter(ShowSeatsTable.id == showSeatId))!
                    return makeShowSeat(from: row)
                }
        } catch {
            fatalError("Error in DB")
        }
    }
    
    func getPayment(forPaymentId paymentId: Int) -> Payment {
        do {
            let row = try db.pluck(PaymentsTable.table.filter(PaymentsTable.id == paymentId))!
            return makePayment(from: row)
        } catch {
            fatalError("Error in DB")
        }
    }
}
