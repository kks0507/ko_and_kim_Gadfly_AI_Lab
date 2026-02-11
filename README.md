# Gadfly AI Lab v2.1

**범용 AI 학술 연구소** — Claude Code 에이전트 팀을 활용한 학술 연구 전 과정 지원 시스템

## 개요

Gadfly AI Lab은 Claude Code의 에이전트 정의 파일을 기반으로 구축된 가상 연구소입니다. 8명의 기능별 전문가와 1명의 연구소장이 협업하여 학술 연구의 전 라이프사이클(아이디어 구체화 → 문헌 검색 → 인용 분석 → 방법론 설계 → 데이터 분석 → 고찰/출판)을 지원합니다.

> **"Gadfly"** — 소크라테스가 자신을 아테네의 '등에(gadfly)'에 비유한 데서 유래. 끊임없이 질문하고 비판적으로 사고하게 만드는 역할을 상징합니다.

### v2.1 주요 변경사항

- **트리 구조 커맨드 통합**: 11개 커맨드 → **6개 대분류** (스마트 라우터 + 5단계)
- **시스템 설계 전문가 추가**: 7명 → **8명 체제** (Systems Architect 신규)
- **자율 판단 강화**: 사용자는 대분류만 호출, Director가 하위 기능을 자율 선택·실행
- **IMRaD 정렬**: 논문 구조(Introduction-Method-Results-and-Discussion)에 맞춘 5단계 워크플로

### v2 주요 변경사항

- **도메인 → 기능 기반 전환**: 5명의 도메인 전문가 → 6명의 기능 전문가
- **범용 연구소**: 교육공학/AIED 특화 → 모든 학문 분야 지원
- **연구 라이프사이클 완성**: 결과 분석 + 고찰 + 출판 전략까지
- **한국 학술 맥락 통합**: 한국 DB 검색, KCI 투고, IRB 절차 등
- **tensw-claude 통합**: 팀/회사 프레임워크 + 대시보드 UI
- **Lit Review 양식**: 표준 문헌 분석 양식 + 정밀 인용 시스템
- **학술 시각화**: PaperBanana 참조, APA 표/그림 자동 기획 + Matplotlib 코드 생성

## 조직도

```
설립자/총책임자 (사람)
  └── 연구소장 (Director) ─── PM + Curator 겸임
        │
        ├── 아이디어부
        │     ├── 브레인스토머 (Ideation) ──── 이론 정당화, 개념 정의
        │     └── 검색전략가 (Search) ──────── Lit Review 구조 + 이중 키워드 검색식
        │
        ├── 분석부
        │     ├── 문헌분석가 (Literature) ──── 정밀 인용 추출, 품질 평가
        │     └── 데이터분석가 (Data) ────── 통계 분석, APA 결과, 고찰, 시각화 기획
        │
        ├── 방법론부
        │     ├── 방법론전문가 (Methodology) ── 방법론 추천, IRB, 재현가능성
        │     └── 기획전문가 (Planning) ──────── 온톨로지, 전략, 피어리뷰 시뮬레이션
        │
        └── 시스템설계부 (NEW)
              └── 시스템설계전문가 (Systems Architect) ── 아키텍처, 기술스택, AI/ML, 프로토타입
```

## 커맨드 트리 구조

```
/gadfly (스마트 라우터 — 자연어 요청 → 자동 판단)
  │
  ├── /gadfly-plan (연구 계획 및 기획)
  │     ├── 프로젝트 생성
  │     ├── 아이디어 브레인스토밍
  │     ├── 검색 전략 수립
  │     └── 시스템 설계 (시스템 연구 시)
  │
  ├── /gadfly-litreview (문헌 고찰)
  │     ├── 단일 논문 정밀 인용
  │     ├── 단일 논문 종합 분석
  │     ├── 일괄 논문 분석
  │     ├── 문헌 리뷰 종합
  │     └── 결과 내보내기
  │
  ├── /gadfly-method (연구 방법)
  │     ├── 방법론 추천
  │     ├── 실험 설계
  │     ├── IRB/윤리
  │     ├── 설문/도구 설계
  │     └── 시스템 구현 전략 (시스템 연구 시)
  │
  ├── /gadfly-result (결과)
  │     ├── 통계 분석 + APA 보고
  │     └── 시각화 (표/그림 + 코드) ← 자동 연계
  │
  └── /gadfly-conclusion (결론 및 고찰)
        ├── 고찰 초안
        ├── 한계점 분석
        ├── 후속 연구 제안
        ├── 기여 진술
        └── 출판 전략
```

**핵심 원리**: 사용자는 대분류 커맨드만 호출 + 자연어로 요청 → Director가 하위 기능 자율 판단 → 해당 에이전트만 배치

## 설치

### 요구사항

- [Claude Code](https://claude.com/claude-code) 설치
- Git
- (권장) jq — settings.json 자동 병합
- (권장) Node.js/npm — 대시보드 사용
- (권장) tmux — 실시간 팀 모드

### 설치 방법

```bash
git clone https://github.com/kks0507/ko_and_kim_Gadfly_AI_Lab.git
cd ko_and_kim_Gadfly_AI_Lab
chmod +x install.sh
./install.sh
```

설치 스크립트가 자동으로 수행하는 작업:
1. tensw-claude 서브모듈 초기화
2. 에이전트 8개 → `~/.claude/agents/` 심링크
3. 커맨드 6개 → `~/.claude/commands/` 심링크
4. tensw 커맨드 → `~/.claude/commands/` 심링크
5. 연구소 프리셋 등록
6. `~/.claude/settings.json`에 Agent Teams 설정 병합
7. 대시보드 npm install

### 제거

```bash
./uninstall.sh
```

연구 데이터(`projects/`, `output/`, `knowledge/`)는 보존됩니다.

## 사용법

Claude Code 실행 후 슬래시 커맨드로 연구소를 활용합니다.

### 스마트 라우터 (자연어로 시작)

```
/gadfly "AI 기반 학습 시스템 연구를 계획하고 싶어"
/gadfly "이 논문들을 분석해줘" --project my-thesis
/gadfly "방법론을 추천해줘" --project my-thesis
```

### 5단계 워크플로

```
/gadfly-plan <아이디어>                        연구 기획 (프로젝트+아이디어+검색전략+시스템설계)
/gadfly-litreview <논문.pdf> --project <이름>   문헌 고찰 (인용/분석/일괄/리뷰/내보내기)
/gadfly-method --project <이름>                방법론 설계 (추천+실험+IRB+설문+시스템구현)
/gadfly-result <데이터> --project <이름>        결과 분석 (통계+시각화 자동 연계)
/gadfly-conclusion --project <이름>             결론 (고찰+한계+기여+출판전략)
```

### tensw 팀 모드

```
/tensw-company research-lab                    연구소 팀 모드 (8명 동시 가동)
/tensw-team                                    커스텀 팀 구성
```

## 연구 워크플로 예시

```
1. /gadfly-plan "AI 기반 학습 시스템 연구"        연구 기획 (자동: 프로젝트+아이디어+검색전략+시스템설계)
2. /gadfly-litreview papers/ --project my-thesis  문헌 고찰 (자동: 일괄분석+리뷰종합)
3. /gadfly-method --project my-thesis             방법론 설계 (자동: 방법론추천+실험설계+IRB)
4. /gadfly-result data.csv --project my-thesis    결과 분석 (자동: 통계+시각화)
5. /gadfly-conclusion --project my-thesis         결론 (자동: 고찰+한계+기여+출판전략)
```

또는 `/gadfly "AI 기반 학습 시스템 연구를 계획하고 싶어"` 한 줄로 시작할 수 있습니다.

## 디렉토리 구조

```
ko_and_kim_Gadfly_AI_Lab/
├── agents/                    # 에이전트 정의 (8명)
│   ├── gadfly-director.md         # 연구소장
│   ├── gadfly-ideation.md         # 브레인스토머
│   ├── gadfly-search-strategist.md # 검색전략가
│   ├── gadfly-literature-analyst.md # 문헌분석가
│   ├── gadfly-methodology.md      # 방법론전문가
│   ├── gadfly-data-analyst.md     # 데이터분석가
│   ├── gadfly-planning.md         # 기획전문가
│   └── gadfly-systems-architect.md # 시스템설계전문가 (NEW)
├── commands/                  # 슬래시 커맨드 (6개 대분류)
│   ├── gadfly.md                  # 스마트 라우터
│   ├── gadfly-plan.md             # 연구 기획
│   ├── gadfly-litreview.md        # 문헌 고찰
│   ├── gadfly-method.md           # 연구 방법
│   ├── gadfly-result.md           # 결과
│   ├── gadfly-conclusion.md       # 결론 및 고찰
│   └── internal/                  # 내부 레퍼런스 (Director 참조용)
│       ├── brainstorm.md
│       ├── search-strategy.md
│       ├── cite.md
│       ├── analyze.md
│       ├── batch.md
│       ├── review.md
│       ├── methodology.md
│       ├── results.md
│       ├── visualize.md
│       ├── new-project.md
│       └── export.md
├── knowledge/                 # 지식베이스
│   ├── core/                      # 핵심 지식 (7개)
│   │   ├── research-methodology.md
│   │   ├── statistical-methods.md
│   │   ├── survey-design.md
│   │   ├── academic-writing.md
│   │   ├── academic-visualization.md
│   │   ├── search-strategies.md
│   │   └── korean-academic-conventions.md
│   ├── domains/                   # 도메인 지식
│   │   ├── ai-systems/
│   │   ├── edtech/
│   │   ├── lis/
│   │   ├── education/
│   │   └── fintech/
│   └── planning/                  # 기획 지식 (Biblo 철학 포함)
├── templates/                 # 출력 양식
│   ├── lit-review-template.md
│   ├── citation-template.md
│   └── visualization-template.md
├── projects/                  # 프로젝트 설정 파일
├── output/                    # 분석 결과물
├── team-configs/              # tensw 팀 프리셋
├── tensw-claude/              # tensw 서브모듈
├── install.sh
├── uninstall.sh
└── README.md
```

## 에이전트 배치 매트릭스

| 요청 유형 | 필수 배치 | 권장 배치 |
|-----------|-----------|-----------|
| 아이디어 구체화 | ideation, planning | search-strategist |
| Lit Review + 검색 전략 | search-strategist, planning | ideation |
| **시스템 설계** | **systems-architect, planning** | **ideation** |
| 정밀 인용 분석 | literature-analyst | — |
| 논문 종합 분석 | literature-analyst, planning | methodology, data-analyst |
| **방법론 추천** | methodology | **systems-architect** (시스템 연구 시) |
| 결과 분석 + 고찰 | data-analyst | methodology, planning |
| 시각화 기획 + 코드 생성 | data-analyst | planning |
| **결론 + 고찰** | data-analyst, planning | methodology, ideation |

## 지식 업그레이드

### 핵심 지식 추가

`knowledge/core/` 폴더에 마크다운 파일을 추가하면 모든 전문가의 역량이 강화됩니다.

### 도메인 지식 추가

`knowledge/domains/<도메인>/` 폴더에 마크다운 파일을 추가하면 해당 분야의 분석이 정교해집니다:

```bash
# 예: 심리학 도메인 추가
mkdir knowledge/domains/psychology
vi knowledge/domains/psychology/research-paradigms.md
```

## 라이선스

MIT License

## 크레딧

- 팀 프레임워크: [tensw-claude](https://github.com/tensw/tensw-claude)
- 기반 플랫폼: [Claude Code](https://claude.com/claude-code) by Anthropic
