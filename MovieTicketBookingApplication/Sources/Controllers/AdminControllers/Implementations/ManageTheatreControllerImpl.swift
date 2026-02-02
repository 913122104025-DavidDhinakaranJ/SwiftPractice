import Errors
import Models
import Repositories

public struct ManageTheatreControllerImpl: ManageTheatreController {
    private let theatreRepository: TheatreRepository
    
    public init(theatreRepository: TheatreRepository) {
        self.theatreRepository = theatreRepository
    }
    
    public func getAllTheatres() -> [Theatre] {
        theatreRepository.getAll()
    }
    
    public func addTheatre(_ theatre: Theatre) throws(RepoError) {
        try theatreRepository.add(theatre: theatre)
    }
    
    public func updateTheatre(_ theatre: Theatre) throws(RepoError) {
        try theatreRepository.update(theatre: theatre)
    }
    
    public func deleteTheatre(_ theatre: Theatre) throws(RepoError) {
        try theatreRepository.remove(theatre: theatre)
    }
}
