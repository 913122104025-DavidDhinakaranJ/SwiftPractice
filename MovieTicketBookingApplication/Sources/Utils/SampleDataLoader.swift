import Foundation
import Models
import Repositories

public struct SampleDataLoader {
    private let movieRepository: MovieRepository
    private let theatreRepository: TheatreRepository
    private let showRepository: ShowRepository
    
    public init(movieRepository: any MovieRepository, theatreRepository: any TheatreRepository, showRepository: any ShowRepository) {
        self.movieRepository = movieRepository
        self.theatreRepository = theatreRepository
        self.showRepository = showRepository
    }
    
    public func loadData() {
        loadSampleMovies()
        loadTheatres()
        loadShows()
    }
    
    // MARK: - 1. Load Movies
    private func loadSampleMovies() {
        // Movie 1: Inception
        var inception = Movie(
            title: "Inception",
            durationInMinutes: 148,
            rating: .pg13,
            releaseDate: makeDate(year: 2010, month: 7, day: 16)
        )
        inception.addGenre(Movie.Genre.sciFi)
        inception.addGenre(Movie.Genre.action)
        inception.addGenre(Movie.Genre.thriller)
        inception.addLanguage(Movie.Language.english)
        
        try? movieRepository.add(movie: inception)
        
        // Movie 2: Interstellar
        var interstellar = Movie(
            title: "Interstellar",
            durationInMinutes: 169,
            rating: .pg13,
            releaseDate: makeDate(year: 2014, month: 11, day: 7)
        )
        interstellar.addGenre(Movie.Genre.sciFi)
        interstellar.addGenre(Movie.Genre.drama)
        interstellar.addGenre(Movie.Genre.adventure)
        interstellar.addLanguage(Movie.Language.english)
        
        try? movieRepository.add(movie: interstellar)
        
        // Movie 3: Vikram
        var vikram = Movie(
            title: "Vikram",
            durationInMinutes: 175,
            rating: .adult,
            releaseDate: makeDate(year: 2022, month: 6, day: 3)
        )
        vikram.addGenre(Movie.Genre.sciFi)
        vikram.addGenre(Movie.Genre.thriller)
        vikram.addGenre(Movie.Genre.mystery)
        vikram.addLanguage(Movie.Language.tamil)
        
        try? movieRepository.add(movie: vikram)
    }
    
    // MARK: - 2. Load Theatres
    private func loadTheatres() {
        // Theatre 1: INOX
        var inox = Theatre(name: "INOX Marina Mall", address: "OMR, Chennai")
        
        try? inox.addHall("Screen 1")
        try? inox.addHall("Screen 2")
        
        var screen1 = inox.halls["Screen 1"]!
        var screen2 = inox.halls["Screen 2"]!
        
        screen1.addSeats(numberOfRows: 5, numberOfSeatsPerRow: 12, type: .regular)
        screen1.addSeats(numberOfRows: 2, numberOfSeatsPerRow: 10, type: .premium)
            
        screen2.addSeats(numberOfRows: 4, numberOfSeatsPerRow: 10, type: .regular)
        
        try? theatreRepository.add(theatre: inox)
        
        // Theatre 2: PVR
        var pvr = Theatre(name: "PVR Phoenix Mall", address: "Velachery, Chennai")
        try? pvr.addHall("Audi 1")
        
        var audi1 = pvr.halls["Audi 1"]!
        
        audi1.addSeats(numberOfRows: 6, numberOfSeatsPerRow: 14, type: .regular)
        audi1.addSeats(numberOfRows: 2, numberOfSeatsPerRow: 12, type: .vip)
        
        try? theatreRepository.add(theatre: pvr)
    }
    
    // MARK: - 3. Load Shows
    private func loadShows() {
        let movies = movieRepository.getAllMovies()
        let theatres = theatreRepository.getAll()
        
        let inception = movies[0]
        let interstellar = movies[1]
        let vikram = movies[2]
        
        let inox = theatres[0]
        let inoxScreen1 = inox.halls["screen 1"]!
        
        // Show 1: Inception Morning
        let show1 = Show(
            movie: inception,
            theatre: inox,
            cinemaHall: inoxScreen1,
            startTime: makeDate(year: 2026, month: 1, day: 15, hour: 9, minute: 30),
            breakTime: 15,
            price: 180.00
        )
        try? showRepository.add(show: show1)
        
        // Show 2: Interstellar Late Night
        let show2 = Show(
            movie: interstellar,
            theatre: inox,
            cinemaHall: inoxScreen1,
            startTime: makeDate(year: 2026, month: 1, day: 15, hour: 22, minute: 00),
            breakTime: 15,
            price: 220.00
        )
        try? showRepository.add(show: show2)
        
        // Show 3: Vikram Afternoon (Different Theatre)
        let pvr = theatres[1]
        let pvrAudi1 = pvr.halls["Audi 1"]!
        
        let show3 = Show(
            movie: vikram,
            theatre: pvr,
            cinemaHall: pvrAudi1,
            startTime: makeDate(year: 2026, month: 1, day: 15, hour: 14, minute: 15),
            breakTime: 20,
            price: 200.00
        )
        try? showRepository.add(show: show3)
    }
    
    // MARK: - Helper
    private func makeDate(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0) -> Date {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        return Calendar.current.date(from: components) ?? Date()
    }
}
