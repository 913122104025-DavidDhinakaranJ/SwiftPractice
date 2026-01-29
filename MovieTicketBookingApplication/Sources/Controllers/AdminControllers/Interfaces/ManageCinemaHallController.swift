import Errors
import Models

public protocol ManageCinemaHallController {
    func addCinemaHall(name: String) throws(TheatreError) -> CinemaHall
    func getCinemaHalls() -> [CinemaHall]
    func removeCinemaHall(cinemaHall: CinemaHall)
    
}
