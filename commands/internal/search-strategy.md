---
allowed-tools: Read, Glob, Grep, Task, Write
description: Lit Review 서술 전략을 설계하고 해외/한국 DB별 검색식을 생성한다.
---

# /gadfly-search-strategy

문헌 고찰의 논리적 서술 구조를 설계하고, 해외/한국 학술 DB별로 복사-붙여넣기 가능한 검색식을 생성합니다.

## 사용법

```
/gadfly-search-strategy <연구 주제 또는 키워드>
/gadfly-search-strategy <연구 주제> --project <프로젝트명>
```

## 실행 절차

### Phase 1: 소장 - 주제 접수 및 개념 확장

1. 연구 주제/키워드를 분석합니다.
2. 프로젝트 설정이 있으면 `projects/<프로젝트명>.md`를 읽어 맥락을 파악합니다.
3. `knowledge/core/korean-academic-conventions.md`를 참조합니다.
4. **기획전문가(planning)**에게 개념 확장을 지시합니다 (온톨로지 기반 상위/인접/하위 개념 도출).

### Phase 2: 기획전문가 - 개념 확장

기획전문가가 온톨로지 역량으로 개념을 확장합니다:
- 핵심 개념의 상위/하위/인접 개념 트리
- 관련 이론 프레임워크 식별
- 개념 간 관계(is_a, requires, enables 등)

### Phase 3: 검색전략가 - 서술 전략 + 검색식 생성

확장된 개념을 바탕으로 **검색전략가(search-strategist)**에게 전략 수립을 지시합니다:

```markdown
# 검색 전략 보고서

## Part 1: Lit Review 서술 전략

### 문헌 고찰 논리 구조
(어떤 순서와 논리로 선행연구를 서술할 것인가)

### 섹션별 분류 체계
| 섹션 | 주제/개념 | 다루어야 할 핵심 이론 | 예상 논문 수 |
|------|----------|---------------------|------------|

### 서술 흐름도
1. (배경 및 문제 제기) →
2. (이론적 기반) →
3. (선행 연구 동향) →
4. (연구 갭 도출) →
5. (본 연구의 위치)

---

## Part 2: 해외 DB 검색 전략 (영어 키워드)

### Scopus 검색식
```
TITLE-ABS-KEY("keyword1" AND "keyword2") AND ...
```
- 필터: 연도 ≥ YYYY, 영어, Article/Review
- 예상 결과 수: ~N건

### Web of Science 검색식
```
TS=("keyword1" AND "keyword2") AND ...
```

### ERIC 검색식
```
(keyword1 AND keyword2) ...
```

### PubMed 검색식 (해당 시)
```
("keyword1"[MeSH]) AND ...
```

---

## Part 3: 한국 DB 검색 전략 (한국어 키워드)

### RISS 검색식
- 검색어: "한국어키워드1" AND "한국어키워드2"
- 검색 필드: 전체, 제목, 키워드
- 필터: 학위논문/학술지논문, 연도

### KCI 검색식
- 검색어: ...
- KCI 등재지/등재후보지 필터

### DBPIA 검색식
- 검색어: ...

---

## Part 4: 이중 키워드 매핑 테이블

| 개념 | 영어 키워드 | 한국어 키워드 | 유의어(영) | 유의어(한) |
|------|------------|-------------|-----------|-----------|

---

## PRISMA 흐름도 템플릿

```
식별(Identification): DB 검색 결과 총 N건
    ↓ 중복 제거: N건
스크리닝(Screening): 제목/초록 검토 N건
    ↓ 제외: N건 (사유: ...)
적격성(Eligibility): 전문 검토 N건
    ↓ 제외: N건 (사유: ...)
포함(Included): 최종 분석 대상 N건
```

## 스노우볼링 계획

### 핵심 논문 (Seed Papers)
| # | 저자(연도) | 제목 | 선정 이유 |
|---|-----------|------|-----------|

### 추적 방향
- Forward snowballing: 핵심 논문을 인용한 후속 연구
- Backward snowballing: 핵심 논문의 참고문헌
```

보고서를 `output/<프로젝트 또는 search-strategy>/search-strategy-YYYY-MM-DD.md`로 저장합니다.
