import Repositories
import Models
import Utils

public final class ApplicationContext {
    nonisolated(unsafe) private static let shared: ApplicationContext = .init()
    
    private let userRepository: some UserRepository = InMemoryRepository.getInMemoryRepository()
    private let movieRepository: some MovieRepository = InMemoryRepository.getInMemoryRepository()
    private let theatreRepository: some TheatreRepository = InMemoryRepository.getInMemoryRepository()
    private let showRepository: some ShowRepository = InMemoryRepository.getInMemoryRepository()
    
    private let customerFactory = CustomerFactory()
    private let adminFactory = AdminFactory()
    
    private let sessionContext = SessionContext()
    
    private init() {
        userRepository.save(user: Admin(username: "superAdmin", password: "superAdmin@1234", superAdmin: true))
        SampleDataLoader.loadData(movieRepository: movieRepository, theatreRepository: theatreRepository, showRepository: showRepository)
    }
    
    public static func getApplicationContext() -> ApplicationContext { shared }
    
    public func getUserRepository() -> some UserRepository { userRepository }
    
    public func getMovieRepository() -> some MovieRepository { movieRepository }
    
    public func getTheatreRepository() -> some TheatreRepository { theatreRepository }
    
    public func getShowRepository() -> some ShowRepository { showRepository }
    
    public func getCustomerFactory() -> CustomerFactory { customerFactory }
    
    public func getAdminFactory() -> AdminFactory { adminFactory }
    
    public func getSessionContext() -> SessionContext { sessionContext }
}
