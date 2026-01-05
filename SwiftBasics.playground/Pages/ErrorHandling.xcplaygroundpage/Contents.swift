//Defining error
enum MyError: Error {
    case invalidInput
    case noData
    case unknown
}

let myError: MyError = .unknown
