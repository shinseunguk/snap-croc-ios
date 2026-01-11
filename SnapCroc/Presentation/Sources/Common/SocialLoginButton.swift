import SwiftUI

enum SocialLoginType {
    case apple
    case google
    case kakao

    var title: String {
        switch self {
        case .apple:
            return " Apple로 로그인"
        case .google:
            return "G  Google로 로그인"
        case .kakao:
            return "카카오 로그인"
        }
    }

    var backgroundColor: Color {
        switch self {
        case .apple:
            return .black
        case .google:
            return .white
        case .kakao:
            return .kakaoYellow
        }
    }

    var foregroundColor: Color {
        switch self {
        case .apple:
            return .white
        case .google:
            return Color(hex: "#333333")
        case .kakao:
            return .kakaoBrown
        }
    }

    var hasBorder: Bool {
        switch self {
        case .google:
            return true
        default:
            return false
        }
    }
}

struct SocialLoginButton: View {
    let type: SocialLoginType
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(type.title)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(type.foregroundColor)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(type.backgroundColor)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(hex: "#DDDDDD"), lineWidth: type.hasBorder ? 1 : 0)
                )
        }
    }
}
