import Foundation

public protocol AuthRepository {
    func socialLogin(request: SocialLoginRequest) async throws -> AuthResponse
    func saveAuthToken(_ token: AuthToken) async throws
    func getAuthToken() async throws -> AuthToken?
    func deleteAuthToken() async throws
}
