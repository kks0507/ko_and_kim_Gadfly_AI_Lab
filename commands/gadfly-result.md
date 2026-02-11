---
allowed-tools: Read, Glob, Grep, Task, Write, Bash
description: 결과 분석 통합. 통계 분석 + APA 보고와 시각화(표/그림 + 코드)를 자동으로 연계 실행한다.
---

# /gadfly-result — 결과

결과 분석과 시각화를 통합 지원합니다. 통계 분석 + APA 보고를 수행한 후, **자동으로 시각화 기획까지 연계** 실행합니다 (기존에는 별도 커맨드).

## 사용법

```
/gadfly-result --project <프로젝트명>
/gadfly-result <데이터 파일> --project <프로젝트명>
```

## 하위 기능 트리

| 하위 기능 | 트리거 조건 | 배치 에이전트 | 내부 레퍼런스 |
|-----------|------------|-------------|--------------|
| 통계 분석 + APA 보고 | 데이터/통계 결과 입력 | data-analyst + (methodology) | `commands/internal/results.md` |
| 시각화 (표/그림 + 코드) | 결과 분석 완료 후 자동 | data-analyst + (planning) | `commands/internal/visualize.md` |

## 실행 절차

### Phase 1: Director — 데이터 접수

1. 데이터 소스를 확인합니다:
   - 사용자가 제공한 데이터 파일 (CSV, 통계 출력, 텍스트 등)
   - `output/<프로젝트>/results-*.md` — 기존 결과 보고서
   - 사용자가 직접 입력한 통계 결과
2. 데이터가 없으면 사용자에게 분석 결과를 직접 입력하도록 안내합니다.
3. `projects/<프로젝트명>.md`를 읽어 연구 맥락을 파악합니다:
   - 연구 질문(RQ)
   - 이론적 프레임워크
   - 방법론 유형
   - 주요 변인
4. 기존 `output/<프로젝트>/` 폴더에서 이전 분석 결과 (methodology 보고서 등)를 확인합니다.

### Phase 2: 통계 분석 + APA 보고 (`commands/internal/results.md` 참조)

**데이터 분석가(gadfly-data-analyst)**에게 Task를 지시합니다:

- 데이터/결과 + 프로젝트 맥락 전달
- `knowledge/core/statistical-methods.md` 참조 지시
- `knowledge/core/academic-writing.md` 참조 지시
- `knowledge/core/korean-academic-conventions.md` 참조 지시
- 다음 사항 요청:
  - 기술 통계 (평균, 표준편차, 빈도 등)
  - 추론 통계 (가설 검정, APA 형식 보고)
  - 효과크기 (Cohen's d, η², f² 등)
  - Discussion 초안 (주요 발견, 선행연구 비교, 이론적/실천적 함의, 한계)
  - Contribution 정리 (이론적, 방법론적, 실천적)

필요 시 **방법론전문가(gadfly-methodology)**도 추가 배치하여 결과 해석의 방법론적 타당성을 검증합니다.

### Phase 3: 시각화 기획 + 코드 생성 (자동 연계) (`commands/internal/visualize.md` 참조)

**결과 분석이 완료되면 자동으로 시각화 기획을 진행합니다.**

**데이터 분석가(gadfly-data-analyst)**에게 추가 Task를 지시합니다:

- Phase 2의 결과 + 프로젝트 맥락 전달
- `knowledge/core/academic-visualization.md` 참조 지시
- `templates/visualization-template.md` 양식 준수 지시
- 다음 사항 요청:
  - 각 RQ/결과별 최적 시각화 유형 선택 (표 vs 그림, 차트 유형)
  - APA 형식 표(Table) 마크다운 작성
  - APA 형식 그림(Figure)용 Matplotlib 코드 생성
    - APA 스타일 설정 (set_apa_style 함수)
    - 색각 이상 대응 팔레트 (Wong 2011)
    - 300 DPI PNG + PDF 벡터 출력
    - 모듈형 데이터 입력 섹션
  - 본문 통합 참조 문장 제안
  - 투고 체크리스트

필요 시 **기획전문가(gadfly-planning)**도 추가 배치하여 시각 자료 배치 순서를 검토합니다.

### Phase 4: Director — 통합 보고서 출력

```markdown
# 결과 분석 + 시각화 보고서

## 프로젝트: [프로젝트명]

---

## Part 1: Results (결과)

### 1.1 기술 통계
(평균, 표준편차, 빈도 등 — APA 형식 테이블)
| 변인 | M | SD | N |
|------|---|----|----|

### 1.2 추론 통계
| 가설/RQ | 분석 방법 | 결과 | 효과크기 | p |
|---------|----------|------|---------|---|

### 1.3 효과크기 해석

---

## Part 2: Discussion (고찰)

### 2.1 주요 발견 요약
### 2.2 선행연구와의 비교
### 2.3 이론적 함의
### 2.4 실천적 함의
### 2.5 한계
### 2.6 후속 연구 제안

---

## Part 3: Contribution (기여)

### 이론적 기여
### 방법론적 기여
### 실천적 기여

---

## Part 4: 시각화

### 4.1 시각화 기획 요약
| # | 유형 | 제목 | 시각화 방식 | 해당 RQ | 선택 근거 |
|---|------|------|-----------|---------|----------|

### 4.2 APA Tables
(마크다운 형식 테이블)

### 4.3 APA Figures — Python 코드
(Matplotlib 코드, 복사-붙여넣기 가능)

### 4.4 본문 통합 가이드
(Table/Figure 참조 문장)

### 4.5 투고 체크리스트
- [ ] 모든 표/그림이 본문에서 참조되었는가?
- [ ] APA 7th 형식 준수
- [ ] Figure 해상도 300 DPI 이상
- [ ] 색각 이상 대응
- [ ] 소수점 자릿수 통일

---

## Part 5: 출판 전략 (선택)
| 항목 | 내용 |
|------|------|
| 추천 학술지 | |
| 투고 전략 | |
| 예상 리비전 포인트 | |
```

보고서를 `output/<프로젝트>/results-YYYY-MM-DD.md`로 저장합니다.
Figure 코드 파일을 `output/<프로젝트>/figures/figure1.py`, `figure2.py` 등으로 개별 저장합니다.
