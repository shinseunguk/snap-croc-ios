import Foundation

public struct AuthResponse: Equatable, Codable {
    public let user: User
    public let token: AuthToken

    public init(user: User, token: AuthToken) {
        self.user = user
        self.token = token
    }
}
