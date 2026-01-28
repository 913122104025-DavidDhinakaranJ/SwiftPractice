import Models

public final class SelectionContext {
    public private(set) var selectedMovie: Movie?
    public private(set) var selectedTheatre: Theatre?
    public private(set) var selectedCinemaHall: CinemaHall?
    public private(set) var selectedShow: Show?
    
    public func select(_ movie: Movie) {
        selectedMovie = movie
    }
    
    public func select(_ theatre: Theatre) {
        selectedTheatre = theatre
    }
    
    public func select(_ cinemaHall: CinemaHall) {
        selectedCinemaHall = cinemaHall
    }
    
    public func select(_ show: Show) {
        selectedShow = show
    }
    
    public func clearMovieSelection() {
        selectedMovie = nil
    }
    
    public func clearTheatreSelection() {
        selectedTheatre = nil
    }
    
    public func clearCinemaHallSelection() {
        selectedCinemaHall = nil
    }
    
    public func clearShowSelection() {
        selectedShow = nil
    }
}
