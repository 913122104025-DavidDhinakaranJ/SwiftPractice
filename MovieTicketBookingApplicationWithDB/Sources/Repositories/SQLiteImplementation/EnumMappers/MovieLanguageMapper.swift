import Models

enum MovieLanguageMapper: StringEnumMapper {
    static var mappings: [Movie.Language : String] {[
        .bengali: "Bengali",
        .english: "English",
        .hindi: "Hindi",
        .japanese: "Japanese",
        .tamil: "Tamil"
    ]}
}
