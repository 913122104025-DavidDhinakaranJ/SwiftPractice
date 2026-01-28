import Errors
import Models

public protocol ManageCinemaHallController {
    func addCinemaHall(name: String) throws(CinemaHallError) -> CinemaHall
    func getCinemaHalls() -> [CinemaHall]
    func removeCinemaHall(cinemaHall: CinemaHall)
    
}
