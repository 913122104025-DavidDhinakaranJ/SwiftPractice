import AuthLib
import Foundation
import CryptoKit

public class User: AuthenticatableUser {
    public private(set) var id: Int64?
    public enum Role { case customer, admin }
    public let username: String
    private var passwordHash: String
    public let role: Role
    public private(set) var isBlocked: Bool = false
    public var passwordHashForStorage: String { passwordHash }
    
    public init(username: String, password: String, role: Role) {
        self.id = nil
        self.username = username
        passwordHash = Self.hash(password)
        self.role = role
    }
    
    init(id: Int64, username: String, passwordHash: String, role: Role, isBlocked: Bool) {
        self.id = id
        self.username = username
        self.passwordHash = passwordHash
        self.role = role
        self.isBlocked = isBlocked
    }
    
    public func validate(password: String) -> Bool {
        Self.hash(password) == passwordHash
    }
    
    public func changePassword(newPassword: String) {
        passwordHash = Self.hash(newPassword)
    }
    
    public func block() {
        isBlocked = true
    }
    
    public func unblock() {
        isBlocked = false
    }
    
    public func setId(_ id: Int64) {
        if self.id == nil { self.id = id }
    }
    
    private static func hash(_ password: String) -> String {
        let data = Data(password.utf8)
        let digest = SHA256.hash(data: data)
        return digest.map { String(format: "%02x", $0) }.joined()
    }
}
