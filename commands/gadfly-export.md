---
allowed-tools: Read, Glob, Grep, Write
description: 분석 결과를 CSV 또는 마크다운 테이블로 내보낸다.
---

# /gadfly-export

프로젝트의 분석 결과를 CSV 또는 마크다운 형식으로 내보냅니다.

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
2. 각 논문의 분석 데이터를 추출합니다.

### Phase 2: CSV 생성 (--format csv 또는 both)

CSV 칼럼 구조:
```
ID/분류,저자(연도),논문 제목,학술지/출처,연구 목적,연구 방법론,주요 결과,핵심 키워드,한계점/후속연구,정밀 인용-Location,정밀 인용-Original Text,정밀 인용-Reason,진행 상태
```

저장 위치: `output/<프로젝트>/lit-review-YYYY-MM-DD.csv`

### Phase 3: 마크다운 테이블 생성 (--format markdown 또는 both)

```markdown
# 문헌 분석 테이블

| ID/분류 | 저자(연도) | 논문 제목 | 학술지 | 연구 목적 | 방법론 | 주요 결과 | 키워드 | 한계점 | 정밀 인용 | 상태 |
|---------|-----------|----------|--------|----------|--------|----------|--------|--------|----------|------|
```

저장 위치: `output/<프로젝트>/lit-review-YYYY-MM-DD.md`

### Phase 4: 결과 보고

- 총 내보낸 논문 수, 저장 경로를 터미널에 출력합니다.
- CSV는 바로 복사해서 스프레드시트에 붙여넣을 수 있는 형식입니다.
