import ComposableArchitecture
import Foundation
import Domain

public struct LoginFeature: Reducer {
    public struct State: Equatable {
        public var isLoading: Bool = false
        public var errorMessage: String?

        public init() {}
    }

    public enum Action: Equatable {
        case appleLoginTapped
        case googleLoginTapped
        case kakaoLoginTapped
        case loginResponse(Result<AuthResponse, Error>)

        public static func == (lhs: Action, rhs: Action) -> Bool {
            switch (lhs, rhs) {
            case (.appleLoginTapped, .appleLoginTapped),
                 (.googleLoginTapped, .googleLoginTapped),
                 (.kakaoLoginTapped, .kakaoLoginTapped):
                return true
            case let (.loginResponse(.success(lhsResponse)), .loginResponse(.success(rhsResponse))):
                return lhsResponse == rhsResponse
            case (.loginResponse(.failure), .loginResponse(.failure)):
                return true
            default:
                return false
            }
        }
    }

    public init() {}

    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            @Dependency(\.socialLoginUseCase) var socialLoginUseCase

            switch action {
            case .appleLoginTapped:
                state.isLoading = true
                state.errorMessage = nil
                return .run { send in
                    do {
                        let response = try await socialLoginUseCase.execute(provider: .apple)
                        await send(.loginResponse(.success(response)))
                    } catch {
                        await send(.loginResponse(.failure(error)))
                    }
                }

            case .googleLoginTapped:
                state.isLoading = true
                state.errorMessage = nil
                return .run { send in
                    do {
                        let response = try await socialLoginUseCase.execute(provider: .google)
                        await send(.loginResponse(.success(response)))
                    } catch {
                        await send(.loginResponse(.failure(error)))
                    }
                }

            case .kakaoLoginTapped:
                state.isLoading = true
                state.errorMessage = nil
                return .run { send in
                    do {
                        let response = try await socialLoginUseCase.execute(provider: .kakao)
                        await send(.loginResponse(.success(response)))
                    } catch {
                        await send(.loginResponse(.failure(error)))
                    }
                }

            case let .loginResponse(.success(response)):
                state.isLoading = false
                print("Login success: \(response.user.name ?? "Unknown") - \(response.user.provider)")
                // TODO: Navigate to main screen
                return .none

            case let .loginResponse(.failure(error)):
                state.isLoading = false
                if let socialError = error as? SocialLoginError {
                    switch socialError {
                    case .loginCancelled:
                        state.errorMessage = nil
                    case .unsupportedProvider:
                        state.errorMessage = "지원하지 않는 로그인 방식입니다"
                    case .invalidToken:
                        state.errorMessage = "로그인에 실패했습니다. 다시 시도해주세요"
                    }
                } else {
                    state.errorMessage = "로그인에 실패했습니다: \(error.localizedDescription)"
                }
                print("Login failed: \(error)")
                return .none
            }
        }
    }
}
