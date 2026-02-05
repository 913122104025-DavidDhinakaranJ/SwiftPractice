import Models

enum MovieGenreMapper: StringEnumMapper {
    static var mappings: [Movie.Genre : String] {[
        .action: "Action",
        .adventure: "Adventure",
        .comedy: "Comedy",
        .drama: "Drama",
        .fantasy: "Fantasy",
        .horror: "Horror",
        .mystery: "Mystery",
        .romance: "Romance",
        .sciFi: "Science Fiction",
        .thriller: "Thriller",
        .western: "Western"
    ]}
}
