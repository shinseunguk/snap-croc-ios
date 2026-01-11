import Foundation
import Domain

public protocol AuthAPIClient {
    func socialLogin(request: SocialLoginRequest) async throws -> AuthResponse
}

public final class DefaultAuthAPIClient: AuthAPIClient {
    private let baseURL: String
    private let urlSession: URLSession

    public init(
        baseURL: String? = nil,
        urlSession: URLSession = .shared
    ) {
        // Info.plist에서 API_BASE_URL 읽어오기 (Debug/Release 분기 처리)
        if let baseURL = baseURL {
            self.baseURL = baseURL
        } else if let plistURL = Bundle.main.infoDictionary?["API_BASE_URL"] as? String {
            self.baseURL = plistURL
        } else {
            // Fallback: 설정이 없을 경우 기본값 사용
            self.baseURL = "https://api.snapcroc.com"
        }
        self.urlSession = urlSession
    }

    public func socialLogin(request: SocialLoginRequest) async throws -> AuthResponse {
        let url = URL(string: "\(baseURL)/auth/social-login")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "provider": request.provider.rawValue,
            "idToken": request.idToken,
            "accessToken": request.accessToken as Any
        ]

        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, response) = try await urlSession.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw AuthAPIError.invalidResponse
        }

        let authResponse = try JSONDecoder().decode(AuthResponse.self, from: data)
        return authResponse
    }
}

public enum AuthAPIError: Error {
    case invalidResponse
    case networkError
}
