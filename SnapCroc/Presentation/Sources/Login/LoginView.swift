import SwiftUI
import ComposableArchitecture

public struct LoginView: View {
    let store: StoreOf<LoginFeature>

    public init(store: StoreOf<LoginFeature>) {
        self.store = store
    }

    public var body: some View {
        ZStack {
            Color.darkBackground
                .ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 120)

                // Logo
                VStack(spacing: 0) {
                    Text("CROCO")
                        .font(.system(size: 28, weight: .black))
                        .foregroundColor(.crocoBite)

                    Text("BITE")
                        .font(.system(size: 28, weight: .black))
                        .foregroundColor(.crocoBiteRed)
                }

                Spacer()
                    .frame(height: 50)

                // Description
                Text("간편하게 로그인하세요")
                    .font(.system(size: 14))
                    .foregroundColor(.textSecondary)

                Spacer()
                    .frame(height: 80)

                // Social Login Buttons
                VStack(spacing: 20) {
                    SocialLoginButton(type: .apple) {
                        store.send(.appleLoginTapped)
                    }
                    .disabled(store.isLoading)

                    SocialLoginButton(type: .google) {
                        store.send(.googleLoginTapped)
                    }
                    .disabled(store.isLoading)

                    SocialLoginButton(type: .kakao) {
                        store.send(.kakaoLoginTapped)
                    }
                    .disabled(store.isLoading)
                }
                .padding(.horizontal, 40)

                // Error Message
                if let errorMessage = store.errorMessage {
                    Text(errorMessage)
                        .font(.system(size: 12))
                        .foregroundColor(.crocoBiteRed)
                        .padding(.top, 16)
                        .padding(.horizontal, 40)
                        .multilineTextAlignment(.center)
                }

                Spacer()

                // Terms
                Text("로그인 시 이용약관에 동의하게 됩니다")
                    .font(.system(size: 11))
                    .foregroundColor(.textTertiary)
                    .padding(.bottom, 50)
            }

            // Loading Indicator
            if store.isLoading {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()

                ProgressView()
                    .tint(.crocoBite)
                    .scaleEffect(1.5)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(
            store: Store(
                initialState: LoginFeature.State()
            ) {
                LoginFeature()
            }
        )
    }
}
