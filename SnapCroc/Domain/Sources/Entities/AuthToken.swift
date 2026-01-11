import Foundation

public struct AuthToken: Equatable, Codable {
    public let accessToken: String
    public let refreshToken: String?
    public let expiresIn: TimeInterval?

    public init(
        accessToken: String,
        refreshToken: String? = nil,
        expiresIn: TimeInterval? = nil
    ) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.expiresIn = expiresIn
    }
}
