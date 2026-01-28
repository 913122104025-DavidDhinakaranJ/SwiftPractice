import Foundation

public struct ConsoleInputUtil {
    public init() {}
    
    public func readInt(prompt: String) -> Int {
        while true {
            print(prompt, terminator: ": ")
            if let input = readLine(), let number = Int(input) {
                return number
            } else {
                print("Please enter a valid number.")
            }
        }
    }
    
    public func readPositiveInt(prompt: String) -> Int {
        while true {
            let number = readInt(prompt: prompt)
            if number > 0 {
                return number
            } else {
                print("Please enter a positive number.")
            }
        }
    }
    
    public func readString(prompt: String, isEmptyStringAllowed: Bool = true) -> String {
        while true {
            print(prompt, terminator: ": ")
            if let input = readLine(), (isEmptyStringAllowed || !input.isEmpty) {
                return input
            } else {
                print("Empty string is not allowed.")
            }
        }
    }
    
    public func readDate(prompt: String) -> Date {
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
    
    public func readDateTime(prompt: String) -> Date {
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
    
    public func readAmount(prompt: String) -> Double {
        while true {
            print(prompt, terminator: ": ")
            if let input = readLine(), let amount = Double(input), amount >= 0 {
                return amount
            } else {
                print("Please enter a valid amount.")
            }
        }
    }
    
    public func readBool(prompt: String) -> Bool {
        while true {
            print(prompt, terminator: " (yes/no): ")
            if let input = readLine()?.lowercased(), (input == "yes" || input == "no") {
                return input == "yes"
            } else {
                print("Please enter 'yes' or 'no'.")
            }
        }
    }
    
    public func readMenuOption<T : Collection>(prompt: String = "Enter Menu Choice", _ options: T) -> T.Element {
        getSelection(prompt: prompt, from: options)!
    }
    
    public func readChoiceWithExit<T: Collection>(prompt: String = "Enter Choice", _ options: T, stringify: (T.Element) -> String = { "\($0)" }) -> T.Element? {
        getSelection(prompt: prompt, from: options, allowExit: true, stringify: stringify)
    }
    
    private func getSelection<T: Collection>(prompt: String, from options: T, allowExit: Bool = false, stringify: (T.Element) -> String = { "\($0)" }) -> T.Element? {
        for (index, option) in options.enumerated() {
            print("\(index + 1). \(stringify(option))")
        }
        if allowExit { print("0. Exit") }
        
        while true {
            let choice = readInt(prompt: prompt)
            if allowExit && choice == 0 { return nil }
            if choice > 0 && choice <= options.count {
                return options[options.index(options.startIndex, offsetBy: choice - 1)]
            }
            print("Invalid choice. Please try again.")
        }
    }
    
    
}
