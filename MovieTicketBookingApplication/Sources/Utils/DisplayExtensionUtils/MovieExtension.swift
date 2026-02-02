import Models

extension Movie: CustomStringConvertible {
    public var description: String {
        return title
    }
    
    public var detailedDescription: String {
        return """
        🎬 MOVIE DETAILS
        --------------------------------
        Title:        \(title)
        Rating:       \(rating)
        Duration:     \(durationInMinutes) mins
        Genres:       \(genres.map { "\($0)".capitalized }.joined(separator: ", "))
        Languages:    \(languages.map { "\($0)".capitalized }.joined(separator: ", "))
        Release Date: \(releaseDate.displayDate)
        --------------------------------
        """
    }
}
