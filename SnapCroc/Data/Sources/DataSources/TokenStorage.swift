import Foundation
import Domain

public protocol TokenStorage {
    func save(_ token: AuthToken) async throws
    func get() async throws -> AuthToken?
    func delete() async throws
}

public final class KeychainTokenStorage: TokenStorage {
    private let service = "com.snapcroc.auth"
    private let account = "accessToken"

    public init() {}

    public func save(_ token: AuthToken) async throws {
        let encoder = JSONEncoder()
        let data = try encoder.encode(token)

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: data
        ]

        SecItemDelete(query as CFDictionary)
        let status = SecItemAdd(query as CFDictionary, nil)

        guard status == errSecSuccess else {
            throw TokenStorageError.saveFailed
        }
    }

    public func get() async throws -> AuthToken? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true
        ]

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        guard status == errSecSuccess,
              let data = result as? Data else {
            if status == errSecItemNotFound {
                return nil
            }
            throw TokenStorageError.retrieveFailed
        }

        let decoder = JSONDecoder()
        return try decoder.decode(AuthToken.self, from: data)
    }

    public func delete() async throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]

        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw TokenStorageError.deleteFailed
        }
    }
}

public enum TokenStorageError: Error {
    case saveFailed
    case retrieveFailed
    case deleteFailed
}
