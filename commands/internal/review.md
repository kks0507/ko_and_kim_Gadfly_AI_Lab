---
allowed-tools: Read, Glob, Grep, Task, Write
description: 기존 분석 결과를 Pillar별로 종합하여 Literature Review 작성을 위한 종합 보고서를 생성한다.
---

# /gadfly-review

프로젝트에 축적된 분석 결과들을 `Lit_Review_Citation_Matrix_v2.xlsx`의 Pillar 구조에 맞춰 종합하여, Literature Review 작성을 위한 종합 보고서를 생성합니다.

## 사용법

```
/gadfly-review <주제 또는 키워드> --project <프로젝트명>
/gadfly-review --pillar "Pillar B" --project <프로젝트명>
```

## 실행 절차

### Phase 1: 소장 - 기존 분석 결과 수집

1. `output/<프로젝트>/` 폴더의 모든 분석 결과(cite-*.md, analyze-*.md)를 스캔합니다.
2. 각 분석 결과에서 Citation Matrix 테이블을 추출합니다.
3. `Lit_Review_Citation_Matrix_v2.xlsx`의 `필러-키워드 매핑` 시트를 참조하여 Pillar별로 분류합니다.
4. `projects/<프로젝트명>.md`를 읽어 프로젝트 맥락을 파악합니다.
5. `knowledge/core/academic-writing.md`를 참조하여 Literature Review 구조를 확인합니다.

### Phase 2: 기획전문가 + 문헌분석가 - 구조화

**기획전문가(planning)**에게 Task를 지시하여:
- Pillar별 논문 분포 및 연구 동향 분석
- Pillar 간 교차점(cross-pillar connections) 식별
- 연구 흐름의 시간적 변화 파악
- Literature Review 서술 순서 제안 (어떤 Pillar부터 어떤 순서로 써야 하는지)

**문헌분석가(literature-analyst)**에게 Task를 지시하여:
- 킬러 인용구 선별 (전체 인용구 중 Literature Review에서 반드시 사용해야 할 것들)
- 인용 유형별 분포 분석 (근거/대조/Gap/방법론참조)
- 인용구 간 연결 관계 파악 (어떤 인용구끼리 함께 사용하면 효과적인지)

### Phase 3: 소장 - 종합 리뷰 보고서

```markdown
# Literature Review 종합 보고서

## 프로젝트: [프로젝트명]
## 분석 대상: 총 N편 (인용구 M개)

## 1. Pillar별 분석 요약

### Pillar A: [테마명]
- 분석 논문 수: X편
- 핵심 발견: ...
- 주요 Gap: ...

### Pillar B: [테마명]
(동일 구조)

### Pillar C / D...
(동일 구조)

## 2. 통합 Citation Matrix

| Pillar | 검색 키워드 | ID | 저자(연도) | 논문 제목 | 학술지 | 연구 목적 | 방법론 | 주요 결과 | 핵심 인용구 | 출처 위치 | 인용 유형 | 키워드 | 한계점 | 상태 | 파일 |
|--------|-----------|-----|----------|----------|--------|----------|--------|----------|-----------|----------|----------|--------|--------|------|------|
(모든 분석 결과의 행을 통합)

## 3. 인용 유형별 분포

| Pillar | 근거(Support) | 대조(Contrast) | Gap | 방법론참조(Method) | 계 |
|--------|-------------|---------------|-----|------------------|---|
| A | X | X | X | X | X |
| B | X | X | X | X | X |
| 합계 | X | X | X | X | X |

## 4. 연구 갭 분석

### 식별된 Gap (인용 유형이 'Gap'인 것들)
| # | 저자(연도) | Gap 내용 (인용구) | 출처 위치 |
|---|----------|----------------|----------|

### Pillar 간 교차 Gap
- (여러 Pillar에서 공통으로 지적되는 미해결 문제)

## 5. Literature Review 서술 전략

### 권장 서술 순서
1. (어떤 Pillar/주제부터 시작)
2. (어떻게 연결)
3. ...

### 킬러 인용구 Top 10
| 순위 | ID | 저자(연도) | 인용구 (요약) | 인용 유형 | 활용 위치 제안 |
|------|-----|----------|-------------|----------|-------------|

### 추가 수집 필요 영역
- (인용구가 부족한 Pillar/키워드)
- (근거 또는 대조 인용이 부족한 주장)
```

보고서를 `output/<프로젝트>/review-YYYY-MM-DD.md`로 저장합니다.
