import Foundation
import AuthenticationServices
import Domain

public final class AppleLoginClient: NSObject, SocialLoginClient {
    public let provider: SocialLoginProvider = .apple

    private var continuation: CheckedContinuation<SocialLoginRequest, Error>?

    public override init() {
        super.init()
    }

    @MainActor
    public func login() async throws -> SocialLoginRequest {
        return try await withCheckedThrowingContinuation { continuation in
            self.continuation = continuation

            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]

            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        }
    }
}

extension AppleLoginClient: ASAuthorizationControllerDelegate {
    public func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let identityToken = appleIDCredential.identityToken,
              let tokenString = String(data: identityToken, encoding: .utf8) else {
            continuation?.resume(throwing: SocialLoginError.invalidToken)
            return
        }

        let request = SocialLoginRequest(
            provider: .apple,
            idToken: tokenString
        )

        continuation?.resume(returning: request)
        continuation = nil
    }

    public func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithError error: Error
    ) {
        if let authError = error as? ASAuthorizationError,
           authError.code == .canceled {
            continuation?.resume(throwing: SocialLoginError.loginCancelled)
        } else {
            continuation?.resume(throwing: error)
        }
        continuation = nil
    }
}

extension AppleLoginClient: ASAuthorizationControllerPresentationContextProviding {
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            fatalError("No window available")
        }
        return window
    }
}
