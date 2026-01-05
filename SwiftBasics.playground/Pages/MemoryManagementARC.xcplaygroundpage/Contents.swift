//weak reference
class Person {
    var apartment: Apartment?
    
    init(apartment: Apartment?) {
        self.apartment = apartment
    }
    
    deinit {
        print("Person is being deinitialized")
    }
}

class Apartment {
    weak var tenant: Person?  //This doesn't increase the reference count of person object
    deinit {
        print("Apartment is being deinitialized")
    }
}

var apartment: Apartment? = Apartment()

var person: Person? = Person(apartment: apartment)
apartment?.tenant = person

apartment = nil
person = nil


//unowned reference
class Apartment2 {
    unowned var tenant: Person2  //tenant has to outlive apartment
    
    init(tenant: Person2) {
        self.tenant = tenant
    }
    
    deinit {
        print("Apartment2 is being deinitialized")
    }
}

class Person2 {
    var apartment: Apartment2?
    
    init(apartment: Apartment2?) {
        self.apartment = apartment
    }
    
    deinit {
        print("Person2 is being deinitialized")
    }
}

var person2: Person2? = Person2(apartment: nil)
var apartment2: Apartment2? = Apartment2(tenant: person2!)

person2?.apartment = apartment2

apartment2 = nil
person2 = nil

//Closure Capture List
class Counter {
    var count: Int = 0
    var incrementCount: (() -> Void)?
    deinit {
        print("Counter Deinitialized")
    }
    
    func increment() {
        incrementCount = {
            [weak self] in
            self?.count += 1
            print(self?.count ?? 0)
        }
    }
}

var counter: Counter? = Counter()
counter?.increment()
var incrementer = counter?.incrementCount
incrementer?()

counter = nil
incrementer?()
