# SnapCroc

iOS 앱 프로젝트

## 프로젝트 구조

이 프로젝트는 Clean Architecture 기반의 모듈화된 구조로 구성되어 있습니다.

```
SnapCroc/
├── App/              # 앱 진입점 및 설정
├── Presentation/     # UI 레이어 (SwiftUI Views, ViewModels)
├── Domain/          # 비즈니스 로직 (Entities, UseCases, Repository Interfaces)
├── Data/            # 데이터 레이어 (Repository 구현, DataSources)
└── Shared/          # 공통 유틸리티 및 Extensions
```

## 요구사항

- iOS 15.0+
- Xcode 15.0+
- Swift 5.9+
- [Tuist](https://tuist.io) 4.36.0
- [Mise](https://mise.jdx.dev) (선택사항)

## 설치

### 1. Tuist 설치

Mise를 사용하는 경우:
```bash
mise install
```

Homebrew를 사용하는 경우:
```bash
brew install tuist
```

### 2. 환경 설정

API 키 및 민감한 정보를 위한 설정 파일 생성:

```bash
cp Config/Secrets.xcconfig.template Config/Secrets.xcconfig
```

`Config/Secrets.xcconfig` 파일을 열어 실제 API 키와 설정 값을 입력하세요.

### 3. 프로젝트 생성

```bash
tuist install  # 의존성 설치
tuist generate # Xcode 프로젝트 생성
```

### 4. Xcode에서 열기

```bash
open SnapCroc.xcworkspace
```

## 개발

### 프로젝트 재생성

코드나 설정을 변경한 후:

```bash
tuist generate
```

### 의존성 추가

`Tuist/Package.swift`에 의존성을 추가한 후:

```bash
tuist install
tuist generate
```

### 새 모듈 추가

각 모듈은 `SnapCroc/` 디렉토리 내에 `Project.swift` 파일로 정의됩니다.

### 환경 변수 사용

xcconfig 파일에 정의된 환경 변수를 코드에서 사용하려면:

1. Info.plist에 변수 추가:
```xml
<key>APIBaseURL</key>
<string>$(API_BASE_URL)</string>
```

2. Swift 코드에서 읽기:
```swift
let apiBaseURL = Bundle.main.infoDictionary?["APIBaseURL"] as? String
```

## 빌드

### Debug 빌드
```bash
xcodebuild -workspace SnapCroc.xcworkspace -scheme SnapCroc-Workspace -configuration Debug
```

### Release 빌드
```bash
xcodebuild -workspace SnapCroc.xcworkspace -scheme SnapCroc-Workspace -configuration Release
```

## 아키텍처

### Clean Architecture

- **Presentation Layer**: SwiftUI Views와 ViewModels
- **Domain Layer**: 비즈니스 로직과 Entity 정의
- **Data Layer**: API 통신 및 데이터 저장소
- **Shared**: 공통 유틸리티

### 의존성 규칙

```
Presentation → Domain ← Data
     ↓
  Shared
```

## 라이선스

TBD
