import Foundation

public struct Movie {
    public enum Genre: CaseIterable {
        case action, comedy, drama, fantasy, horror, sciFi, thriller, western, mystery, romance, adventure
    }

    public enum Language: CaseIterable {
        case tamil, japanese, hindi, english, bengali
    }

    public enum Rating: CaseIterable {
        case g, pg, pg13, adult
    }
        
    public let title: String
    public private(set) var genres: Set<Genre> = []
    public private(set) var languages: Set<Language> = []
    public private(set) var durationInMinutes: Int
    public let rating: Rating
    public private(set) var releaseDate: Date
    
    public init(title: String, durationInMinutes: Int, rating: Rating, releaseDate: Date) {
        self.title = title
        self.durationInMinutes = durationInMinutes
        self.rating = rating
        self.releaseDate = releaseDate
    }
    
    public mutating func addGenre(_ genre: Genre) {
        genres.insert(genre)
    }
    
    public mutating func removeGenre(_ genre: Genre) {
        genres.remove(genre)
    }
    
    public mutating func addLanguage(_ language: Language) {
        languages.insert(language)
    }
    
    public mutating func removeLanguage(_ language: Language) {
        languages.remove(language)
    }
    
    public mutating func updateDuration(to newDuration: Int) {
        durationInMinutes = newDuration
    }
    
    public mutating func updateReleaseDate(to newReleaseDate: Date) {
        releaseDate = newReleaseDate
    }
}
