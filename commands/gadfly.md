---
allowed-tools: Read, Glob, Grep, Task, Write, Bash, AskUserQuestion
description: 스마트 라우터. 자연어 요청을 분석하여 5개 연구 단계(plan/litreview/method/result/conclusion) 중 적합한 것을 자동 판단하고 실행한다.
---

# /gadfly — 스마트 라우터

자연어 요청을 분석하여 Gadfly AI Lab의 5개 연구 단계 중 적합한 것을 자동으로 판단하고 실행합니다. 사용자는 무엇을 하고 싶은지만 말하면 됩니다.

## 사용법

```
/gadfly <자연어 요청>
/gadfly <자연어 요청> --project <프로젝트명>
```

## 예시

```
/gadfly "AI 기반 학습 시스템 연구를 계획하고 싶어"
/gadfly "이 논문 분석해줘" papers/paper1.pdf --project my-thesis
/gadfly "방법론을 추천해줘" --project my-thesis
/gadfly "통계 결과를 정리하고 시각화해줘" data.csv --project my-thesis
/gadfly "고찰과 한계점을 작성해줘" --project my-thesis
```

## 실행 절차

### Step 1: 요청 분석

사용자의 자연어 요청에서 의도를 파악합니다. 다음 키워드/의도 패턴으로 5개 단계를 매칭합니다:

| 단계 | 매칭 키워드/의도 | 실행할 로직 |
|------|-----------------|------------|
| **연구 기획** | 아이디어, 기획, 계획, 프로젝트, 브레인스토밍, 검색 전략, 시스템 설계, 연구 시작, 주제, 새 연구, RQ | `/gadfly-plan` 로직 |
| **문헌 고찰** | 논문, 선행연구, 인용, 문헌, 검색, PDF, 분석, 리뷰, 내보내기, export, CSV, 배치, 일괄, cite | `/gadfly-litreview` 로직 |
| **연구 방법** | 방법론, 실험, 설계, IRB, 윤리, 설문, 도구, 측정, 샘플, 표본, 연구 설계, 시스템 구현 | `/gadfly-method` 로직 |
| **결과** | 결과, 통계, 분석, 시각화, 표, 그림, figure, table, APA, 데이터, 효과크기, p값 | `/gadfly-result` 로직 |
| **결론/고찰** | 고찰, 한계, 기여, 출판, 투고, 결론, 토론, discussion, 후속 연구, 시사점, 저널 | `/gadfly-conclusion` 로직 |

### Step 2: 판단이 애매한 경우

키워드가 겹치거나 의도가 불명확하면 AskUserQuestion으로 확인합니다:

```
어떤 단계의 지원이 필요한가요?
1. 연구 기획 (아이디어 구체화, 검색 전략, 시스템 설계)
2. 문헌 고찰 (논문 분석, 인용 추출, 리뷰 종합)
3. 연구 방법 (방법론 추천, 실험 설계, IRB)
4. 결과 분석 (통계, 시각화, APA 보고)
5. 결론 및 고찰 (고찰, 한계, 기여, 출판 전략)
```

### Step 3: 해당 단계 실행

판단된 단계의 전체 로직을 실행합니다. 각 단계의 상세 로직은 다음 커맨드 파일을 참조합니다:

- **연구 기획** → `commands/gadfly-plan.md` 로직 실행
- **문헌 고찰** → `commands/gadfly-litreview.md` 로직 실행
- **연구 방법** → `commands/gadfly-method.md` 로직 실행
- **결과** → `commands/gadfly-result.md` 로직 실행
- **결론/고찰** → `commands/gadfly-conclusion.md` 로직 실행

해당 커맨드 파일을 Read로 읽은 뒤, 그 안에 기술된 Phase 전체를 동일하게 실행합니다.

### Step 4: 프로젝트 컨텍스트

- `--project`가 지정되면 해당 프로젝트 설정을 로드합니다.
- 지정되지 않았지만 프로젝트가 필요한 작업이면 `projects/` 폴더를 스캔하여 기존 프로젝트 목록을 보여주고 선택하게 합니다.
- 프로젝트가 아예 없으면 프로젝트 생성을 먼저 안내합니다.
