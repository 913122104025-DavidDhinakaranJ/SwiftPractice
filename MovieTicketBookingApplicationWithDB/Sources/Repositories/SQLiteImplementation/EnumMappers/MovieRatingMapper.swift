import Models

enum MovieRatingMapper: StringEnumMapper {
    static var mappings: [Movie.Rating : String] {[
        .adult: "Adult",
        .g: "G",
        .pg: "PG",
        .pg13: "PG-13"
    ]}
}
