import Foundation

public struct SocialLoginRequest: Equatable {
    public let provider: SocialLoginProvider
    public let idToken: String
    public let accessToken: String?

    public init(
        provider: SocialLoginProvider,
        idToken: String,
        accessToken: String? = nil
    ) {
        self.provider = provider
        self.idToken = idToken
        self.accessToken = accessToken
    }
}
