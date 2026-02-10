# Gadfly AI Lab

**AI 기반 학술 연구소** - Claude Code 에이전트 팀을 활용한 학술 문헌 분석 및 연구 기획 시스템

## 개요

Gadfly AI Lab은 Claude Code의 에이전트 정의 파일을 기반으로 구축된 가상 연구소입니다. 5명의 도메인 전문가와 1명의 연구소장이 협업하여 학술 논문을 다각도로 분석하고, 연구 아이디어를 구체화합니다.

> **"Gadfly"** - 소크라테스가 자신을 아테네의 '등에(gadfly)'에 비유한 데서 유래. 끊임없이 질문하고 비판적으로 사고하게 만드는 역할을 상징합니다.

## 연구 도메인

- **교육공학 + AI**: AI 기반 교육 시스템 기획, 설계 및 구현
- **문헌정보학 + AI**: AI 기반 학술정보관 시스템 기획, 설계 및 구현
- **핀테크 + AI**: (확장 예정)

## 조직도

```
설립자/총책임자 (사람)
  └── 연구소장 (Director) ─── PM + Curator 겸임
        ├── AI시스템 전문가 ──── 기술적 실현 가능성 분석
        ├── 교육공학 전문가 ──── 교수-학습 설계 이론 분석
        ├── 문헌정보 전문가 ──── 정보 조직/검색/접근성 분석
        ├── 교육전문가 ────────── 현장 적용 가능성 분석 (모드 전환)
        └── 기획전문가 ────────── 온톨로지 기반 전략 수립
```

## 설치

```bash
git clone https://github.com/kks0507/ko_and_kim_Gadfly_AI_Lab.git
cd ko_and_kim_Gadfly_AI_Lab
chmod +x install.sh
./install.sh
```

## 제거

```bash
./uninstall.sh
```

연구 데이터(`projects/`, `output/`, `knowledge/`)는 보존됩니다.

## 사용법

Claude Code 실행 후 슬래시 커맨드로 연구소를 활용합니다:

### 논문 분석 (단건)
```
/gadfly-analyze <논문.pdf> --project <프로젝트명>
```

### 논문 일괄 분석 (폴더)
```
/gadfly-batch <논문폴더> --project <프로젝트명>
```

### 연구 아이디어 구체화
```
/gadfly-ideate <러프한 아이디어>
```

### 문헌 리뷰 종합
```
/gadfly-review <주제> --project <프로젝트명>
```

### 결과 내보내기
```
/gadfly-export --project <프로젝트명> --format csv|markdown|both
```

### 새 프로젝트 생성
```
/gadfly-new-project <프로젝트명>
```

## 디렉토리 구조

```
ko_and_kim_Gadfly_AI_Lab/
├── agents/              # 에이전트 정의 (연구소장 + 전문가 5명)
├── commands/            # 슬래시 커맨드 (6개)
├── knowledge/           # 도메인 지식 (업그레이드 가능)
│   ├── ai-systems/
│   ├── edtech/
│   ├── lis/
│   ├── education/
│   ├── planning/
│   └── fintech/         # 확장 대비
├── projects/            # 프로젝트 설정 파일
├── output/              # 분석 결과물
├── team-configs/        # 팀 기능 확장 대비
├── install.sh
├── uninstall.sh
└── README.md
```

## 도메인 지식 업그레이드

`knowledge/` 폴더에 마크다운 파일을 추가하면 전문가의 역량이 강화됩니다:

```bash
# 예: AI 시스템 전문가에게 새 지식 추가
vi knowledge/ai-systems/new-topic.md
```

에이전트 정의 파일은 수정할 필요 없이 지식만 추가하면 됩니다.

## 새 도메인 추가

1. `knowledge/<도메인>/` 폴더 생성 및 지식 파일 작성
2. `agents/gadfly-<도메인>.md` 에이전트 정의 파일 작성
3. `./install.sh` 재실행

## 팀 기능 확장 (예정)

현재는 소장이 Task 도구로 전문가를 순차/병렬 호출하는 구조입니다. 향후 Claude Code의 TeamCreate 기능을 활용한 실시간 팀 협업 모드를 지원할 예정입니다.

## 라이선스

MIT License

## 크레딧

- 영감: [tensw-claude](https://github.com/tensw/tensw-claude) - 에이전트 회사 컨셉
- 프레임워크: [Claude Code](https://claude.com/claude-code) by Anthropic
