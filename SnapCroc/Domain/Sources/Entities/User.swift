import Foundation

public struct User: Equatable, Codable {
    public let id: String
    public let email: String?
    public let name: String?
    public let profileImageURL: String?
    public let provider: SocialLoginProvider

    public init(
        id: String,
        email: String? = nil,
        name: String? = nil,
        profileImageURL: String? = nil,
        provider: SocialLoginProvider
    ) {
        self.id = id
        self.email = email
        self.name = name
        self.profileImageURL = profileImageURL
        self.provider = provider
    }
}
