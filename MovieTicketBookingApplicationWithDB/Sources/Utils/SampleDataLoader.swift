import Foundation
import Models
import Repositories

public enum SampleDataLoader {

    // MARK: - Entry Point
    public static func loadData(
        movieRepository: any MovieRepository,
        theatreRepository: any TheatreRepository,
        showRepository: any ShowRepository
    ) {
        loadSampleMovies(into: movieRepository)
        loadTheatres(into: theatreRepository)
        loadShows(
            movieRepository: movieRepository,
            theatreRepository: theatreRepository,
            showRepository: showRepository
        )
    }

    // MARK: - 1. Load Movies
    private static func loadSampleMovies(
        into movieRepository: any MovieRepository
    ) {
        // 1. Action / Sci-Fi
        var inception = Movie(
            title: "Inception",
            durationInMinutes: 148,
            rating: .pg13,
            releaseDate: makeDate(year: 2010, month: 7, day: 16)
        )
        inception.addGenre(.action)
        inception.addGenre(.sciFi)
        inception.addGenre(.thriller)
        inception.addLanguage(.english)
        try? movieRepository.add(movie: inception)

        // 2. Drama / Romance
        var titanic = Movie(
            title: "Titanic",
            durationInMinutes: 195,
            rating: .pg13,
            releaseDate: makeDate(year: 1997, month: 12, day: 19)
        )
        titanic.addGenre(.drama)
        titanic.addGenre(.romance)
        titanic.addLanguage(.english)
        try? movieRepository.add(movie: titanic)

        // 3. Fantasy / Adventure
        var lotr = Movie(
            title: "The Lord of the Rings: The Fellowship of the Ring",
            durationInMinutes: 178,
            rating: .pg13,
            releaseDate: makeDate(year: 2001, month: 12, day: 19)
        )
        lotr.addGenre(.fantasy)
        lotr.addGenre(.adventure)
        lotr.addLanguage(.english)
        try? movieRepository.add(movie: lotr)

        // 4. Mystery / Drama (Japanese)
        var rashomon = Movie(
            title: "Rashomon",
            durationInMinutes: 88,
            rating: .pg,
            releaseDate: makeDate(year: 1950, month: 8, day: 26)
        )
        rashomon.addGenre(.mystery)
        rashomon.addGenre(.drama)
        rashomon.addLanguage(.japanese)
        try? movieRepository.add(movie: rashomon)

        // 5. Comedy / Drama (Tamil)
        var anbe = Movie(
            title: "Anbe Sivam",
            durationInMinutes: 160,
            rating: .pg,
            releaseDate: makeDate(year: 2003, month: 1, day: 14)
        )
        anbe.addGenre(.drama)
        anbe.addGenre(.comedy)
        anbe.addLanguage(.tamil)
        try? movieRepository.add(movie: anbe)
    }

    // MARK: - 2. Load Theatres
    private static func loadTheatres(
        into theatreRepository: any TheatreRepository
    ) {
        // =====================================================
        // Theatre 1: Grand Cinema
        // =====================================================
        let grandCinema = Theatre(
            name: "Grand Cinema",
            address: "123 Main Road, Chennai"
        )

        try! grandCinema.addHall("Main Hall")
        try! grandCinema.addSeatsToHall(
            "Main Hall",
            numberOfRows: 5,
            numberOfSeatsPerRow: 12,
            type: .regular
        )
        try! grandCinema.addSeatsToHall(
            "Main Hall",
            numberOfRows: 2,
            numberOfSeatsPerRow: 10,
            type: .premium
        )

        try! grandCinema.addHall("Premium Hall")
        try! grandCinema.addSeatsToHall(
            "Premium Hall",
            numberOfRows: 4,
            numberOfSeatsPerRow: 8,
            type: .vip
        )

        try! grandCinema.addHall("Small Hall")
        try! grandCinema.addSeatsToHall(
            "Small Hall",
            numberOfRows: 3,
            numberOfSeatsPerRow: 6,
            type: .regular
        )

        try! theatreRepository.add(theatre: grandCinema)

        // =====================================================
        // Theatre 2: City Multiplex
        // =====================================================
        let cityMultiplex = Theatre(
            name: "City Multiplex",
            address: "45 Lake View Street, Bengaluru"
        )

        try! cityMultiplex.addHall("Screen 1")
        try! cityMultiplex.addSeatsToHall(
            "Screen 1",
            numberOfRows: 6,
            numberOfSeatsPerRow: 14,
            type: .regular
        )

        try! cityMultiplex.addHall("Screen 2")
        try! cityMultiplex.addSeatsToHall(
            "Screen 2",
            numberOfRows: 4,
            numberOfSeatsPerRow: 10,
            type: .premium
        )
        try! cityMultiplex.addSeatsToHall(
            "Screen 2",
            numberOfRows: 1,
            numberOfSeatsPerRow: 8,
            type: .vip
        )

        try! cityMultiplex.addHall("Screen 3")
        try! cityMultiplex.addSeatsToHall(
            "Screen 3",
            numberOfRows: 3,
            numberOfSeatsPerRow: 8,
            type: .regular
        )

        try! theatreRepository.add(theatre: cityMultiplex)
    }

    // MARK: - 3. Load Shows
    private static func loadShows(
        movieRepository: any MovieRepository,
        theatreRepository: any TheatreRepository,
        showRepository: any ShowRepository
    ) {
        let movies = movieRepository.getAll()
        let theatres = theatreRepository.getAll()

        let inception = movies.first { $0.title == "Inception" }!
        let titanic = movies.first { $0.title == "Titanic" }!
        let lotr = movies.first { $0.title.contains("Lord of the Rings") }!

        let grandCinema = theatres.first { $0.name == "Grand Cinema" }!
        let cityMultiplex = theatres.first { $0.name == "City Multiplex" }!

        let mainHall = grandCinema["Main Hall"]!
        let premiumHall = grandCinema["Premium Hall"]!
        let screen2 = cityMultiplex["Screen 2"]!

        let morningShow = Show(
            movie: inception,
            theatre: grandCinema,
            cinemaHall: mainHall,
            startTime: makeDate(year: 2026, month: 2, day: 15, hour: 10),
            breakTime: 15,
            price: 180.0
        )
        try! showRepository.add(show: morningShow)

        let eveningShow = Show(
            movie: titanic,
            theatre: grandCinema,
            cinemaHall: premiumHall,
            startTime: makeDate(year: 2026, month: 2, day: 15, hour: 18, minute: 30),
            breakTime: 20,
            price: 320.0
        )
        try! showRepository.add(show: eveningShow)

        let lateNightShow = Show(
            movie: lotr,
            theatre: cityMultiplex,
            cinemaHall: screen2,
            startTime: makeDate(year: 2026, month: 2, day: 15, hour: 21, minute: 45),
            breakTime: 15,
            price: 350.0
        )
        try! showRepository.add(show: lateNightShow)
    }

    // MARK: - Helper
    private static func makeDate(
        year: Int,
        month: Int,
        day: Int,
        hour: Int = 0,
        minute: Int = 0
    ) -> Date {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        return Calendar.current.date(from: components)!
    }
}
