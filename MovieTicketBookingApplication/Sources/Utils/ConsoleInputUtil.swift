import Foundation

public struct ConsoleInputUtil {
    private init() {}
    
    public static func readInt(prompt: String) -> Int {
        while true {
            print(prompt, terminator: ": ")
            if let input = readLine(), let number = Int(input) {
                return number
            } else {
                print("Please enter a valid number.")
            }
        }
    }
    
    public static func readPositiveInt(prompt: String) -> Int {
        while true {
            let number = readInt(prompt: prompt)
            if number > 0 {
                return number
            } else {
                print("Please enter a positive number.")
            }
        }
    }
    
    public static func readString(prompt: String, isEmptyStringAllowed: Bool) -> String {
        while true {
            print(prompt, terminator: ": ")
            if let input = readLine(), (isEmptyStringAllowed || !input.isEmpty) {
                return input
            } else {
                print("Empty string is not allowed.")
            }
        }
    }
    
    public static func readDate(prompt: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        while true {
            print(prompt, terminator: " (dd-MM-yyyy): ")
            if let input = readLine(), let date = dateFormatter.date(from: input) {
                return date
            } else {
                print("Please enter a valid date in the format 'dd-MM-yyyy'.")
            }
        }
    }
    
    public static func readDateTime(prompt: String) -> Date {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        
        while true {
            print(prompt, terminator: " (dd-MM-yyyy HH:mm): ")
            if let input = readLine(), let date = dateFormatter.date(from: input) {
                return date
            } else {
                print("Please enter a valid date and time in the format 'dd-MM-yyyy HH:mm'.")
            }
        }
    }
    
    public static func readAmount(prompt: String) -> Double {
        while true {
            print(prompt, terminator: ": ")
            if let input = readLine(), let amount = Double(input), amount >= 0 {
                return amount
            } else {
                print("Please enter a valid amount.")
            }
        }
    }
    
    public static func readBool(prompt: String) -> Bool {
        while true {
            print(prompt, terminator: " (yes/no): ")
            if let input = readLine()?.lowercased(), (input == "yes" || input == "no") {
                return input == "yes"
            } else {
                print("Please enter 'yes' or 'no'.")
            }
        }
    }
}
