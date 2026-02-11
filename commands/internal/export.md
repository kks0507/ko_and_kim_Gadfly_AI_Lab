---
allowed-tools: Read, Glob, Grep, Write
description: 분석 결과를 CSV 또는 마크다운 테이블로 내보낸다. Lit Review 양식 + 정밀 인용 칼럼 포함.
---

# /gadfly-export

프로젝트의 분석 결과를 CSV 또는 마크다운 형식으로 내보냅니다. Lit Review 양식의 모든 필드와 정밀 인용 칼럼을 포함합니다.

## 사용법

```
/gadfly-export --project <프로젝트명>
/gadfly-export --project <프로젝트명> --format csv
/gadfly-export --project <프로젝트명> --format markdown
/gadfly-export --project <프로젝트명> --format both
```

기본값: `--format both`

## 실행 절차

### Phase 1: 데이터 수집

1. `output/<프로젝트>/` 폴더의 모든 분석 결과를 스캔합니다.
2. 각 논문의 Lit Review 양식 데이터를 추출합니다.
3. `templates/lit-review-template.md`를 참조하여 칼럼 구조를 확인합니다.

### Phase 2: CSV 생성 (--format csv 또는 both)

CSV 칼럼 구조 (Lit Review 양식 기반):
```
ID/분류,저자(연도),논문 제목,학술지/출처,DOI,연구 목적,연구 방법론,주요 결과,이론적 프레임워크,핵심 키워드,한계점/후속연구,내 논문과의 연관성,방법론적 품질,정밀 인용-Location,정밀 인용-Original Text,정밀 인용-맥락,정밀 인용-Reason,정밀 인용-통합제안,진행 상태
```

- 하나의 논문에 여러 인용이 있으면 인용별로 별도 행 생성 (기본 정보는 동일)
- 저장 위치: `output/<프로젝트>/lit-review-YYYY-MM-DD.csv`

### Phase 3: 마크다운 테이블 생성 (--format markdown 또는 both)

```markdown
# 문헌 분석 테이블

## 기본 정보
| ID/분류 | 저자(연도) | 논문 제목 | 학술지 | 연구 목적 | 방법론 | 주요 결과 | 키워드 | 한계점 | 품질 | 상태 |
|---------|-----------|----------|--------|----------|--------|----------|--------|--------|------|------|

## 정밀 인용 목록
| # | 저자 | Location | Original Text | Reason | 통합 제안 |
|---|------|----------|---------------|--------|----------|
```

- 저장 위치: `output/<프로젝트>/lit-review-YYYY-MM-DD.md`

### Phase 4: 결과 보고

- 총 내보낸 논문 수, 총 인용 수, 저장 경로를 터미널에 출력합니다.
- CSV는 바로 복사해서 스프레드시트에 붙여넣을 수 있는 형식입니다.
