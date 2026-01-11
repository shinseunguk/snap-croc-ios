import Foundation
import Domain

public final class DefaultAuthRepository: AuthRepository {
    private let apiClient: AuthAPIClient
    private let tokenStorage: TokenStorage

    public init(
        apiClient: AuthAPIClient,
        tokenStorage: TokenStorage
    ) {
        self.apiClient = apiClient
        self.tokenStorage = tokenStorage
    }

    public func socialLogin(request: SocialLoginRequest) async throws -> AuthResponse {
        return try await apiClient.socialLogin(request: request)
    }

    public func saveAuthToken(_ token: AuthToken) async throws {
        try await tokenStorage.save(token)
    }

    public func getAuthToken() async throws -> AuthToken? {
        return try await tokenStorage.get()
    }

    public func deleteAuthToken() async throws {
        try await tokenStorage.delete()
    }
}
