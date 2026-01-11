import Foundation

public protocol SocialLoginUseCase {
    func execute(provider: SocialLoginProvider) async throws -> AuthResponse
}

public final class DefaultSocialLoginUseCase: SocialLoginUseCase {
    private let authRepository: AuthRepository
    private let socialLoginClients: [SocialLoginProvider: SocialLoginClient]

    public init(
        authRepository: AuthRepository,
        socialLoginClients: [SocialLoginProvider: SocialLoginClient]
    ) {
        self.authRepository = authRepository
        self.socialLoginClients = socialLoginClients
    }

    public func execute(provider: SocialLoginProvider) async throws -> AuthResponse {
        guard let client = socialLoginClients[provider] else {
            throw SocialLoginError.unsupportedProvider
        }

        // 1. 소셜 로그인으로 토큰 획득
        let loginRequest = try await client.login()

        // 2. 백엔드에 토큰 전송하여 인증
        let authResponse = try await authRepository.socialLogin(request: loginRequest)

        // 3. 토큰 저장
        try await authRepository.saveAuthToken(authResponse.token)

        return authResponse
    }
}

public enum SocialLoginError: Error {
    case unsupportedProvider
    case loginCancelled
    case invalidToken
}
