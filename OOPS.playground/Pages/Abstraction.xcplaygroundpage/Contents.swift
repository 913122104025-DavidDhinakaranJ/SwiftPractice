protocol StorageService {
    func save(data: String)
}

class DiskStorage: StorageService {
    func save(data: String) {
        print("Saving \(data) to disk storage")
    }
}

class CloudStorage: StorageService {
    func save(data: String) {
        print("Saving \(data) to cloud storage")
    }
}

class StorageManager {
    private var storage: any StorageService
    
    init(storage: StorageService) {
        self.storage = storage
    }
    
    func save(data: String) {
        storage.save(data: data)
    }
}

let storageManager = StorageManager(storage: DiskStorage())
storageManager.save(data: "Hello, World!")
