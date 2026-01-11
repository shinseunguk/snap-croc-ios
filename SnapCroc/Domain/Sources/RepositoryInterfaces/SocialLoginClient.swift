import Foundation

public protocol SocialLoginClient {
    var provider: SocialLoginProvider { get }
    func login() async throws -> SocialLoginRequest
}
