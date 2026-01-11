# 소셜 로그인 구현 완료 상황

## 구현 완료된 부분

### 1. Domain 레이어
- ✅ `SocialLoginProvider`: 소셜 로그인 타입 (Apple, Google, Kakao)
- ✅ `User`: 사용자 모델
- ✅ `AuthToken`: 인증 토큰 모델
- ✅ `SocialLoginRequest`: 소셜 로그인 요청
- ✅ `AuthResponse`: 인증 응답
- ✅ `AuthRepository`: 인증 Repository 인터페이스
- ✅ `SocialLoginClient`: 소셜 로그인 클라이언트 인터페이스
- ✅ `SocialLoginUseCase`: 소셜 로그인 UseCase

### 2. Data 레이어
- ✅ `DefaultAuthRepository`: AuthRepository 구현
- ✅ `AuthAPIClient`: 백엔드 API 클라이언트
- ✅ `KeychainTokenStorage`: 토큰 저장소 (Keychain)
- ✅ `AppleLoginClient`: Apple 로그인 클라이언트
- ✅ `GoogleLoginClient`: Google 로그인 클라이언트
- ⚠️ `KakaoLoginClient`: Kakao 로그인 클라이언트 (빌드 이슈)

### 3. Presentation 레이어
- ✅ `LoginFeature`: TCA Reducer with 소셜 로그인 로직
- ✅ `LoginView`: 소셜 로그인 UI
- ✅ `SocialLoginDependency`: TCA Dependency 설정

### 4. App 레이어
- ✅ Info.plist 설정 (URL Schemes, LSApplicationQueriesSchemes)
- ✅ URL 핸들링 (onOpenURL)
- ⚠️ Kakao SDK 초기화 (빌드 이슈로 임시 비활성화 필요)

## 설정이 필요한 부분

### 1. Google Client ID
파일: `SnapCroc/Presentation/Sources/Login/SocialLoginDependency.swift`
```swift
let googleClient = GoogleLoginClient(
    clientID: "YOUR_GOOGLE_CLIENT_ID" // TODO: 실제 Google Client ID로 변경
)
```

Google Cloud Console에서 OAuth 2.0 클라이언트 ID를 생성하고 여기에 입력하세요.

### 2. Google Reversed Client ID
파일: `Tuist/ProjectDescriptionHelpers/Project+Templates.swift`
```swift
"CFBundleURLSchemes": ["com.googleusercontent.apps.YOUR_REVERSED_CLIENT_ID"]
```

Google Client ID를 역순으로 변경하여 입력하세요.
예: `123456-abc.apps.googleusercontent.com` → `com.googleusercontent.apps.123456-abc`

### 3. Kakao App Key
파일: `Tuist/ProjectDescriptionHelpers/Project+Templates.swift`
```swift
"CFBundleURLSchemes": ["kakaoYOUR_KAKAO_APP_KEY"]
"KAKAO_APP_KEY": "YOUR_KAKAO_APP_KEY"
```

Kakao Developers에서 앱을 생성하고 네이티브 앱 키를 입력하세요.

### 4. 백엔드 API URL
파일: `SnapCroc/Data/Sources/DataSources/AuthAPIClient.swift`
```swift
baseURL: String = "https://api.snapcroc.com" // TODO: 실제 API URL로 변경
```

실제 백엔드 서버 URL로 변경하세요.

## Kakao SDK 빌드 이슈 해결 방법

현재 Kakao SDK가 Tuist와 함께 제대로 빌드되지 않는 문제가 있습니다. 다음과 같이 해결할 수 있습니다:

### 옵션 1: CocoaPods 사용
Tuist가 CocoaPods를 지원하므로, KakaoSDK를 CocoaPods를 통해 추가합니다.

### 옵션 2: 수동 XCFramework 추가
Kakao SDK를 직접 다운로드하여 XCFramework로 추가합니다.

### 옵션 3: Kakao 로그인 비활성화
Apple과 Google 로그인만 먼저 구현하고, Kakao는 나중에 추가합니다.

## 테스트 방법

### Apple Login 테스트
1. 실제 기기 필요 (시뮬레이터에서도 가능하지만 Apple ID 필요)
2. Capabilities에 "Sign in with Apple" 추가 필요
3. Bundle ID가 Apple Developer에 등록되어 있어야 함

### Google Login 테스트
1. Google Cloud Console에서 OAuth 클라이언트 ID 생성
2. iOS 번들 ID 등록
3. Client ID를 코드에 적용

### 로그인 흐름
1. 사용자가 소셜 로그인 버튼 클릭
2. 각 SDK를 통해 소셜 로그인 수행
3. ID Token 획득
4. 백엔드로 ID Token 전송
5. 백엔드에서 JWT 등 자체 토큰 발급
6. 토큰을 Keychain에 저장
7. 메인 화면으로 이동

## Clean Architecture 구조

```
App (진입점, URL 핸들링)
  ↓
Presentation (UI, TCA)
  ↓
Domain (비즈니스 로직, UseCase)
  ↓
Data (Repository 구현, API, SDK 연동)
```

## 다음 단계

1. ⚠️ Kakao SDK 빌드 이슈 해결
2. 실제 Google Client ID 설정
3. 실제 Kakao App Key 설정
4. 백엔드 API URL 설정
5. Sign in with Apple 권한 추가
6. 실제 기기에서 테스트
7. 에러 핸들링 개선
8. 로그아웃 기능 추가
9. 토큰 갱신 로직 추가
10. 메인 화면으로 네비게이션 추가
