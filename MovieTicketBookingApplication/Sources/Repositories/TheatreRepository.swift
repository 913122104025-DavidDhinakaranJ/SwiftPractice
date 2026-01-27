import Models

public protocol TheatreRepository {
    func save(theatre: Theatre)
    func remove(theatre: Theatre)
    
    func getAll() -> [Theatre]
}
