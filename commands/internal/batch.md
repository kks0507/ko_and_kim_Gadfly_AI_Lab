---
allowed-tools: Read, Glob, Grep, Task, Write, Bash
description: 논문 폴더 일괄 분석. 기능별 전문가가 순차 분석 후 종합 비교 매트릭스를 생성한다.
---

# /gadfly-batch

논문 폴더를 통째로 Gadfly AI Lab에 넘겨 일괄 분석합니다.

## 사용법

```
/gadfly-batch <폴더 경로> --project <프로젝트명>
```

## 실행 절차

### Phase 1: 소장 - 폴더 스캔

1. Glob 도구로 폴더 내 분석 가능한 파일을 스캔합니다 (PDF, MD 등).
2. 파일 목록을 정리하고 총 분석 대상 수를 보고합니다.
3. `projects/<프로젝트명>.md`를 읽어 프로젝트 맥락을 파악합니다.
4. `templates/lit-review-template.md`를 읽어 출력 양식을 확인합니다.

```
스캔 결과: 총 N편의 논문 발견
1. paper-a.pdf
2. paper-b.pdf
...
분석을 시작합니다.
```

### Phase 2: 순차 분석

각 논문에 대해 `/gadfly-analyze`의 Phase 1~3 로직을 실행합니다.

- 논문별로 진행 상황을 보고합니다: `[2/N] paper-b.pdf 분석 중...`
- 각 논문의 개별 결과를 `output/<프로젝트>/batch-YYYY-MM-DD/` 에 저장합니다.
- 각 결과는 Lit Review 양식으로 출력합니다.

사용 가능한 전문가:
- `gadfly-literature-analyst`: 정밀 인용 추출
- `gadfly-planning`: 온톨로지 구조화
- `gadfly-methodology`: 방법론 평가
- `gadfly-data-analyst`: 결과/통계 평가
- `gadfly-ideation`: 이론 연결
- `gadfly-search-strategist`: 추가 검색 제안

### Phase 3: 종합 비교 분석

모든 논문 분석이 완료되면:

1. **논문 간 공통 키워드/이론 교차점**을 자동 식별합니다.
2. **종합 비교 매트릭스**를 생성합니다:

```markdown
## 일괄 분석 종합 비교표

| # | 저자(연도) | 제목 | 이론적 프레임워크 | 방법론 | 주요 결과 | 우리 연구 관련성 | 방법론적 품질 |
|---|-----------|------|------------------|--------|----------|-----------------|-------------|
| 1 | | | | | | 상/중/하 | 상/중/하 |
| 2 | | | | | | 상/중/하 | 상/중/하 |

## 교차 분석
- 공통 키워드: ...
- 공통 이론적 프레임워크: ...
- 방법론 분포: (양적 N편, 질적 N편, 혼합 N편)
- 연구 갭 패턴: ...
- 시간적 연구 동향: ...

## 통합 온톨로지 맵
(기획전문가의 논문 간 개념 관계 통합)
```

3. 종합 보고서를 `output/<프로젝트>/batch-YYYY-MM-DD/summary.md`로 저장합니다.
4. 개별 CSV 데이터를 `output/<프로젝트>/batch-YYYY-MM-DD/lit-review.csv`로 저장합니다.
