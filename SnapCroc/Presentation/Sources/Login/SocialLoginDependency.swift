import ComposableArchitecture
import Domain
import Data

extension DependencyValues {
    var socialLoginUseCase: SocialLoginUseCase {
        get { self[SocialLoginUseCaseKey.self] }
        set { self[SocialLoginUseCaseKey.self] = newValue }
    }
}

private enum SocialLoginUseCaseKey: DependencyKey {
    static let liveValue: SocialLoginUseCase = {
        // AuthRepository 생성
        // API URL은 Info.plist의 API_BASE_URL에서 자동으로 읽어옴
        // Debug: http://localhost:3000
        // Release: https://api.snapcroc.com
        let apiClient = DefaultAuthAPIClient()
        let tokenStorage = KeychainTokenStorage()
        let authRepository = DefaultAuthRepository(
            apiClient: apiClient,
            tokenStorage: tokenStorage
        )

        // Social Login Clients 생성
        let appleClient = AppleLoginClient()
        // Google/Kakao는 Tuist 호환성 문제로 임시 비활성화
        // let googleClient = GoogleLoginClient(
        //     clientID: "YOUR_GOOGLE_CLIENT_ID"
        // )
        // let kakaoClient = KakaoLoginClient()

        let clients: [SocialLoginProvider: SocialLoginClient] = [
            .apple: appleClient
            // .google: googleClient,
            // .kakao: kakaoClient
        ]

        return DefaultSocialLoginUseCase(
            authRepository: authRepository,
            socialLoginClients: clients
        )
    }()
}
