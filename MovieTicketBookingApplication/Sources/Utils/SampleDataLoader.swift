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
        let inception = Movie(
            title: "Inception",
            durationInMinutes: 148,
            rating: .pg13,
            releaseDate: makeDate(year: 2010, month: 7, day: 16)
        )
        movieRepository.save(movie: inception)
        
        // Movie 2: Interstellar
        let interstellar = Movie(
            title: "Interstellar",
            durationInMinutes: 169,
            rating: .pg13,
            releaseDate: makeDate(year: 2014, month: 11, day: 7)
        )
        movieRepository.save(movie: interstellar)
        
        // Movie 3: Vikram
        let vikram = Movie(
            title: "Vikram",
            durationInMinutes: 175,
            rating: .adult,
            releaseDate: makeDate(year: 2022, month: 6, day: 3)
        )
        movieRepository.save(movie: vikram)
    }
    
    // MARK: - 2. Load Theatres
    private func loadTheatres() {
        // Theatre 1: INOX
        var inox = Theatre(name: "INOX Marina Mall", address: "OMR, Chennai")
        
        try! inox.addHall("Screen 1")
        try! inox.addHall("Screen 2")
        
        var screen1 = inox.halls[0]
        screen1.addSeats(numberOfRows: 5, numberOfSeatsPerRow: 12, type: .regular)
        screen1.addSeats(numberOfRows: 2, numberOfSeatsPerRow: 10, type: .premium)
            
        var screen2 = inox.halls[1]
        screen2.addSeats(numberOfRows: 4, numberOfSeatsPerRow: 10, type: .regular)
        
        theatreRepository.save(theatre: inox)
        
        // Theatre 2: PVR
        var pvr = Theatre(name: "PVR Phoenix Mall", address: "Velachery, Chennai")
        try! pvr.addHall("Audi 1")
        
        var audi1 = pvr.halls[0]
        audi1.addSeats(numberOfRows: 6, numberOfSeatsPerRow: 14, type: .regular)
        audi1.addSeats(numberOfRows: 2, numberOfSeatsPerRow: 12, type: .vip)
        
        theatreRepository.save(theatre: pvr)
    }
    
    // MARK: - 3. Load Shows
    private func loadShows() {
        let movies = movieRepository.getAllMovies()
        let theatres = theatreRepository.getAll()
        
        let inception = movies[0]
        let interstellar = movies[1]
        let vikram = movies[2]
        
        let inox = theatres[0]
        let inoxScreen1 = inox.halls[0]
        
        // Show 1: Inception Morning
        let show1 = Show(
            movie: inception,
            theatre: inox,
            cinemaHall: inoxScreen1,
            startTime: makeDate(year: 2026, month: 1, day: 15, hour: 9, minute: 30),
            breakTime: 15,
            price: 180.00
        )
        showRepository.save(show: show1)
        
        // Show 2: Interstellar Late Night
        let show2 = Show(
            movie: interstellar,
            theatre: inox,
            cinemaHall: inoxScreen1,
            startTime: makeDate(year: 2026, month: 1, day: 15, hour: 22, minute: 00),
            breakTime: 15,
            price: 220.00
        )
        showRepository.save(show: show2)
        
        // Show 3: Vikram Afternoon (Different Theatre)
        let pvr = theatres[1]
        let pvrAudi1 = pvr.halls[0]
        
        let show3 = Show(
            movie: vikram,
            theatre: pvr,
            cinemaHall: pvrAudi1,
            startTime: makeDate(year: 2026, month: 1, day: 15, hour: 14, minute: 15),
            breakTime: 20,
            price: 200.00
        )
        showRepository.save(show: show3)
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
