---
allowed-tools: Read, Glob, Grep, Task, Write, Bash
description: 논문 단건 종합 분석. 전처리된 JSON을 기반으로 다중 전문가가 분석하고 Citation Matrix 16컬럼 양식으로 출력한다.
---

# /gadfly-analyze

논문 한 편을 Gadfly AI Lab의 기능별 전문가들이 다각도로 종합 분석합니다.
최종 결과는 `Lit_Review_Citation_Matrix_v2.xlsx`의 16컬럼 양식에 맞춰 출력됩니다.

## 전제 조건

- PDF는 이미 `commands/internal/preprocess.md`에 의해 전처리되어 있어야 합니다.
- 전처리 결과 JSON이 `output/<프로젝트>/preprocessed/<논문명>.json`에 존재해야 합니다.
- 이 명령은 **PDF를 직접 읽지 않습니다**. 전처리된 JSON 텍스트만 사용합니다.

## 사용법

```
/gadfly-analyze <논문 파일 경로> --project <프로젝트명>
```

## 실행 절차

### Phase 1: 소장 - 접수 및 맥락 파악

1. 전처리된 JSON 파일을 Read 도구로 읽습니다:
   - 경로: `output/<프로젝트>/preprocessed/<논문명>.json`
2. JSON에서 다음을 확인합니다:
   - metadata: 제목, 저자(연도), 학술지, DOI
   - sections[].content, key_points
   - figures, tables 정보
3. `projects/<프로젝트명>.md` 파일을 읽어 프로젝트 맥락을 파악합니다.
4. `Lit_Review_Citation_Matrix_v2.xlsx`의 `필러-키워드 매핑` 시트를 참조하여:
   - 논문 내용과 가장 관련 깊은 **Pillar**를 판단합니다.
   - 해당 Pillar의 **검색 키워드**를 매칭합니다.
   - **ID 접두어**를 확인합니다.
5. `templates/lit-review-template.md`를 읽어 16컬럼 출력 양식을 확인합니다.
6. 논문 내용과 프로젝트 키워드를 대조하여 필요한 전문가를 판단합니다.

### Phase 2: 전문가 배치 및 분석

판단된 전문가들에게 Task 도구를 사용하여 분석을 지시합니다. 각 전문가에게 다음을 전달합니다:
- 전처리 JSON의 관련 섹션 content (원문 텍스트)
- 전처리 JSON의 figures/tables 정보
- 프로젝트 설정: Pillar, 검색 키워드, 연구 주제

**전문가 배치 매트릭스**:
| 요청 유형 | 필수 배치 | 권장 배치 |
|-----------|-----------|-----------|
| 논문 종합 분석 | literature-analyst, planning | methodology, data-analyst |

사용 가능한 전문가:
- `gadfly-literature-analyst`: 문헌분석가 — **정밀 인용 추출 + 인용 유형 분류** (필수)
- `gadfly-planning`: 기획전문가 — Pillar 간 연결, 전략적 위치 파악 (필수)
- `gadfly-methodology`: 방법론 전문가 — 연구 방법론 평가 (권장)
- `gadfly-data-analyst`: 데이터 분석가 — 결과/통계 평가 (권장)

독립적인 분석은 **병렬로 호출**합니다.

### Phase 3: 결과 취합 및 Citation Matrix 양식 출력

1. 전문가들의 분석 결과를 수집합니다.
2. 중복되는 인용 후보를 통합합니다.
3. **Citation Matrix 16컬럼 테이블**로 정제합니다:

```markdown
## [논문 제목] — Citation Matrix

| Pillar | 검색 키워드 | ID | 저자(연도) | 논문 제목 | 학술지 | 연구 목적 | 방법론 | 주요 결과 | 핵심 인용구 | 출처 위치 | 인용 유형 | 키워드 | 한계점 | 상태 | 파일 |
|--------|-----------|-----|----------|----------|--------|----------|--------|----------|-----------|----------|----------|--------|--------|------|------|
| ... | ... | ... | ... | ... | ... | ... | ... | ... | ... | ... | ... | ... | ... | ... | ... |
```

4. **전문가별 심층 분석 부록**을 추가합니다:

```markdown
---

## 전문가 심층 분석

### 기획전문가 분석
- Pillar 내 위치: (이 논문이 해당 Pillar 내에서 차지하는 위치)
- 다른 Pillar와의 연결점: (교차 참조 가능한 개념)
- Literature Review 서술 전략: (이 논문을 LR에서 어떻게 배치할지 제안)

### 방법론 전문가 분석 (해당 시)
- 연구 설계 평가: (강점, 약점)
- 우리 연구 방법론과의 비교: (참고할 점, 차별화 전략)

### 데이터 분석가 분석 (해당 시)
- 통계 방법 적절성: (사용된 분석 방법 평가)
- 결과 신뢰도: (표본 크기, 효과 크기 등)
```

5. 결과를 `output/<프로젝트>/analyze-[논문약칭]-YYYY-MM-DD.md`로 저장합니다.
6. 터미널에 요약을 출력합니다:

```
종합 분석 완료: [논문 제목]
  - Pillar: Pillar B: AI Teammate
  - 검색 키워드: AI as Teammate + CSCL
  - 투입 전문가: literature-analyst, planning, methodology
  - 총 인용구: N개 (근거 X / 대조 Y / Gap Z / 방법론참조 W)
  - 저장: output/<프로젝트>/analyze-[약칭]-YYYY-MM-DD.md
```
