# Gadfly AI Lab Homepage Design

> 수정 요청 시 이 문서의 섹션 번호를 참조하세요.
> 예: "3.2 Research 섹션의 카드 레이아웃을 2열로 바꿔줘"

---

## 1. Overview

| 항목 | 내용 |
|------|------|
| **프로젝트** | Gadfly AI Lab 연구소 홈페이지 |
| **목적** | 연구소 소개, 연구 분야, 연구진 프로필 제공 |
| **타입** | 단일 페이지 SPA (섹션 스크롤) |
| **언어** | 한국어/영어 이중 언어 (i18n 토글) |

## 2. Tech Stack

| 기술 | 용도 |
|------|------|
| **Next.js 15** (App Router) | 프레임워크 |
| **Tailwind CSS 4** | 스타일링 |
| **next-intl** | i18n (KO/EN 전환) |
| **TypeScript** | 타입 안전성 |

### 2.1 프로젝트 구조

```
homepage/
├── public/
│   └── images/
│       ├── hj-ko.png          # HJ.KO 프로필
│       ├── gs-kim.png         # GS.KIM 프로필
│       └── jb-kim.png         # JB.KIM 프로필
├── messages/
│   ├── ko.json                # 한국어 번역
│   └── en.json                # 영어 번역
├── src/
│   └── app/
│       └── [locale]/
│           ├── layout.tsx     # 루트 레이아웃 + 폰트
│           └── page.tsx       # 메인 페이지
│   └── components/
│       ├── Header.tsx         # 네비게이션 + 언어 토글
│       ├── Hero.tsx           # 히어로 섹션
│       ├── About.tsx          # 연구소 소개
│       ├── Research.tsx       # 연구 분야
│       ├── Team.tsx           # 연구진
│       ├── Publications.tsx   # 논문
│       └── Footer.tsx         # 푸터
├── next.config.ts
├── tailwind.config.ts
└── i18n/
    ├── routing.ts             # 라우팅 설정
    └── request.ts             # 요청 설정
```

## 3. Page Sections (위 → 아래 순서)

### 3.1 Header (고정 상단바)

- 왼쪽: Gadfly AI Lab 로고/텍스트
- 가운데: 섹션 네비게이션 (About / Research / Team / Publications)
- 오른쪽: KO | EN 언어 토글 버튼
- 스크롤 시 배경 블러(backdrop-blur) 효과

### 3.2 Hero Section

- 전체 화면 높이 (h-screen)
- 중앙 정렬:
  - 연구소명: **Gadfly AI Lab** (세리프 폰트, 금색/앰버 액센트)
  - 부제: AI-Enhanced Education Research Institute
  - 슬로건: *"Productive Friction, Not Friction Elimination"*
  - 소속: Sungkyunkwan University
- 배경: 짙은 그라디언트 (slate-950 → slate-900)
- 미묘한 파티클/그리드 패턴 (CSS only)

### 3.3 About Section

- 2단 레이아웃 (좌: 텍스트 / 우: 인용구 카드)
- 내용:
  - 비전: AI 교육 설계의 핵심을 '도움의 양'에서 '마찰의 질'로 전환
  - 철학: 소크라테스 Gadfly 정신
  - 인용: "마찰력이 없는 빙판 위에서는 아무리 힘차게 발을 내딛어도 전진할 수 없다"
- 디자인: 인용구는 보더 좌측에 앰버 라인 + 이탤릭

### 3.4 Research Section

5개 연구 분야 카드 (그리드 레이아웃):

| # | 분야명 | 아이콘 모티프 | 설명 |
|---|--------|-------------|------|
| R1 | Educational Friction Framework | ⚡ 마찰력 | F_edu = μ_AI × N_learner 프레임워크 설계 및 검증 |
| R2 | Adversarial AI for Collaborative Learning | 🎭 소크라테스 | The Annoying Socrates — CSCL 환경에서 의도적 인지 마찰을 통한 비판적 사고 촉진 |
| R3 | Cultural AI Design | 🛡️ 방패 | AI Red Team 메커니즘 — 문화적 맥락에 맞춘 마찰 보정 및 사회적 방패 |
| R4 | Student Agency & Learning Acceleration | 🚀 가속 | Appeal 시스템, 인과적 사고 훈련, Progressive Overload 기반 성장 나선 |
| R5 | Real-time Adaptive Education | ⚙️ 적응 | LLM 기반 실시간 N_learner 추정 및 μ_AI 동적 조절 |

- 카드 디자인: slate-800 배경, 호버 시 앰버 보더 글로우
- 반응형: 데스크탑 3열 / 태블릿 2열 / 모바일 1열

### 3.5 Team Section

**계층 구조:**

```
공동 연구소장 (Co-Directors)
├── HJ.KO — 언어공학, 교육학, 저널리즘 | 성균관대학교  [이미지1]
└── GS.KIM — 교육시스템, AI, 문헌정보학 | 성균관대학교  [이미지2]

연구소 고문 (Advisor)
└── JB.KIM — 컴퓨터공학, 교육공학, 생물학 | 성균관대학교  [이미지3]

AI 연구원 (AI Researchers)
├── CLAUDE — 수석연구원 (Senior Researcher) | Anthropic
└── GEMINI — 책임연구원 (Lead Researcher) | Google
```

- 인물 카드: 원형 이미지 + 이름 + 직책 + 연구분야 태그
- AI 연구원: 프로필 이미지 대신 아이콘/이니셜 아바타
- 인물 카드 호버 시 살짝 확대 효과

### 3.6 Publications Section

- 논문 리스트 (카드형):
  - Ko, H., Kim, G., & Kim, J. (2026). *The Annoying Socrates: A Friction-Based Adversarial AI Model for Collaborative Learning.* AIED 2026.
- 각 논문: 제목 + 저자 + 학회/저널 + 키워드 태그

### 3.7 Footer

- 3열 레이아웃:
  - 좌: Gadfly AI Lab 로고 + 간단 소개
  - 중: Quick Links (섹션 앵커)
  - 우: 소속 (성균관대학교) + GitHub 링크
- 하단: Copyright 2026 Gadfly AI Lab

## 4. Design System

### 4.1 Color Palette

| 용도 | 값 | 설명 |
|------|----|------|
| Background Primary | `slate-950` (#020617) | 메인 배경 |
| Background Secondary | `slate-900` (#0f172a) | 카드/섹션 배경 |
| Background Card | `slate-800` (#1e293b) | 카드 내부 |
| Text Primary | `slate-100` (#f1f5f9) | 본문 텍스트 |
| Text Secondary | `slate-400` (#94a3b8) | 보조 텍스트 |
| Accent Primary | `amber-400` (#fbbf24) | 강조, 제목, 호버 |
| Accent Glow | `amber-500/20` | 카드 호버 글로우 |
| Border | `slate-700` (#334155) | 구분선 |

### 4.2 Typography

| 용도 | 폰트 | 스타일 |
|------|------|--------|
| 제목 (EN) | Playfair Display (serif) | Bold, 금색 |
| 제목 (KO) | Noto Serif KR | Bold |
| 본문 | Inter / Noto Sans KR | Regular |
| 코드/수식 | JetBrains Mono | F_edu 등 표기 |

### 4.3 Interactions

- 카드 호버: `scale-[1.02]` + `border-amber-500/30` 글로우
- 섹션 진입: fade-in-up 애니메이션 (CSS `@keyframes` 또는 Intersection Observer)
- 스크롤: smooth scroll 네비게이션
- 언어 전환: 즉시 전환 (페이지 리로드 없음, next-intl 라우팅)

## 5. i18n Strategy

- **라우팅**: `/ko` (기본), `/en`
- **번역 파일**: `messages/ko.json`, `messages/en.json`
- **전환 UI**: 헤더 우측 토글 버튼 (KO | EN)
- **기본 언어**: 한국어
- **폴백**: 번역 키 누락 시 한국어 표시

## 6. Image Assets

| 파일명 | 대상 | 원본 |
|--------|------|------|
| `hj-ko.png` | HJ.KO 프로필 | 사용자 제공 이미지 1 |
| `gs-kim.png` | GS.KIM 프로필 | 사용자 제공 이미지 2 |
| `jb-kim.png` | JB.KIM 프로필 | 사용자 제공 이미지 3 |

## 7. Responsive Breakpoints

| 브레이크포인트 | 레이아웃 |
|--------------|---------|
| `< 640px` (모바일) | 1열, 축소된 네비게이션 |
| `640-1024px` (태블릿) | 2열 그리드 |
| `> 1024px` (데스크탑) | 3열 그리드, 풀 네비게이션 |
