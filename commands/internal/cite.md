---
allowed-tools: Read, Glob, Grep, Task, Write
description: 전처리된 JSON에서 정밀 인용구를 추출하고 Citation Matrix 16컬럼 양식으로 정리한다.
---

# /gadfly-cite

논문 한 편에서 Literature Review 작성에 필요한 정밀 인용구를 추출하고, `Lit_Review_Citation_Matrix_v2.xlsx`의 16컬럼 양식에 맞춰 구조화된 결과를 출력합니다.

## 전제 조건

- PDF는 이미 `commands/internal/preprocess.md`에 의해 전처리되어 있어야 합니다.
- 전처리 결과 JSON이 `output/<프로젝트>/preprocessed/<논문명>.json`에 존재해야 합니다.
- 이 명령은 **PDF를 직접 읽지 않습니다**. 전처리된 JSON 텍스트만 사용합니다.

## 사용법

```
/gadfly-cite <논문 파일 경로> --project <프로젝트명>
```

## 실행 절차

### Phase 1: 소장 - 접수 및 맥락 파악

1. 전처리된 JSON 파일을 Read 도구로 읽습니다:
   - 경로: `output/<프로젝트>/preprocessed/<논문명>.json`
2. JSON에서 다음을 확인합니다:
   - metadata: 제목, 저자(연도), 학술지, DOI
   - sections[].content: 각 섹션의 원문 텍스트
   - figures[].description/interpretation: 그림 해석
   - tables[].markdown/interpretation: 표 데이터 및 해석
3. `projects/<프로젝트명>.md` 파일을 읽어 프로젝트 맥락을 파악합니다.
4. `Lit_Review_Citation_Matrix_v2.xlsx`의 `필러-키워드 매핑` 시트를 참조하여:
   - 논문 내용과 가장 관련 깊은 **Pillar**를 판단합니다.
   - 해당 Pillar의 **검색 키워드**를 매칭합니다.
   - **ID 접두어**를 확인합니다.
5. `templates/lit-review-template.md`를 읽어 16컬럼 출력 양식을 확인합니다.
6. `templates/citation-template.md`를 읽어 인용 추출 형식을 확인합니다.

### Phase 2: 문헌분석가 - 정밀 인용 추출

**문헌분석가(literature-analyst)**에게 Task를 지시합니다:

**전달 내용**:
- 전처리 JSON의 **sections[].content** (원문 텍스트 전체)
- 전처리 JSON의 figures/tables 정보
- 프로젝트 설정: Pillar, 검색 키워드, 연구 주제, 이론적 프레임워크
- `templates/citation-template.md` 형식 준수 지시

**추출 지시 사항**:
1. Literature Review 작성에 직접 활용 가능한 인용구만 선별
2. 각 인용구에 대해:
   - **핵심 인용구**: 원문 그대로 (Strict Verbatim)
   - **출처 위치**: p.#, para.# 또는 L.# 형식
   - **인용 유형**: 근거(Support) / 대조(Contrast) / Gap / 방법론참조(Method) 중 택 1
   - **관련 결과 요약**: 해당 인용구와 직접 관련된 연구 결과 1~2문장
3. 논문 전체에 대해:
   - **연구 목적**: 1문장 요약
   - **연구 방법론**: 연구유형, 참여자수, 분석방법
   - **핵심 키워드**: 쉼표로 구분된 태그
   - **한계점/후속연구**: 저자가 밝힌 한계 + 발견한 빈틈

### Phase 3: 소장 - Citation Matrix 양식 출력

`templates/lit-review-template.md`의 16컬럼 양식에 맞춰 **1인용 = 1행**으로 출력합니다:

```markdown
## [논문 제목] — Citation Matrix

| Pillar | 검색 키워드 | ID | 저자(연도) | 논문 제목 | 학술지 | 연구 목적 | 방법론 | 주요 결과 | 핵심 인용구 | 출처 위치 | 인용 유형 | 키워드 | 한계점 | 상태 | 파일 |
|--------|-----------|-----|----------|----------|--------|----------|--------|----------|-----------|----------|----------|--------|--------|------|------|
| Pillar B: AI Teammate | AI as Teammate + CSCL | PB-AT-001a | Ouyang & Zhang (2024) | AI-driven learning... | Educational Research Review | CSCL에서 AI 기반... | 체계적 문헌리뷰... | 인지적 참여 편중... | "These student-facing..." | p.6, para.2 | Gap | CSCL, AI... | 학회 논문 제외... | 완료 | /path/to/pdf |
| Pillar B: AI Teammate | AI as Teammate + CSCL | PB-AT-001b | Ouyang & Zhang (2024) | (동일 논문 — 인용구 2) | | | | 피드백 유형... | "mirroring information..." | p.9, para.1 | Gap | | | 완료 | |
```

**동일 논문 복수 행 규칙**:
- 첫 행 (001a): 16컬럼 모두 완전 기입
- 이후 행 (001b~): A~B 동일, C는 알파벳 증가, D 동일, E는 `(동일 논문 — 인용구 N)`, F~H 비워둠, I는 해당 인용구 관련 결과만, J~L 새 인용구, M~N 비워둠, O 동일, P 비워둠

4. 결과를 `output/<프로젝트>/cite-[논문약칭]-YYYY-MM-DD.md`로 저장합니다.
5. 터미널에 요약을 출력합니다:

```
인용 추출 완료: [논문 제목]
  - Pillar: Pillar B: AI Teammate
  - 검색 키워드: AI as Teammate + CSCL
  - 총 인용구: N개
  - 인용 유형 분포: 근거 X / 대조 Y / Gap Z / 방법론참조 W
  - 저장: output/<프로젝트>/cite-[약칭]-YYYY-MM-DD.md
```
