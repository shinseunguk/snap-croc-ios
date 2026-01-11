import SwiftUI
import Presentation

@main
struct SnapCrocApp: App {
    init() {
        // Google/Kakao SDK는 Tuist 호환성 문제로 임시 비활성화
        // Apple 로그인만 먼저 구현
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
