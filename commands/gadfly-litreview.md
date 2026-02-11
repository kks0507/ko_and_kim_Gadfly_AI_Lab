---
allowed-tools: Read, Glob, Grep, Task, Write, Bash
description: 문헌 고찰 통합. PDF 전처리 후 단일 논문 인용/분석, 리뷰 종합, 엑셀 내보내기를 자동 판단하여 실행한다.
---

# /gadfly-litreview — Literature Review 작성 지원

학술 논문의 Literature Review 작성을 위한 선행연구 정리를 통합 지원합니다.
모든 분석 결과는 `Lit_Review_Citation_Matrix_v2.xlsx`의 16컬럼 양식에 맞춰 출력됩니다.

## 사용법

```
/gadfly-litreview <논문.pdf> --project <프로젝트명>
/gadfly-litreview --project <프로젝트명>
/gadfly-litreview --project <프로젝트명> --export xlsx
```

## 핵심 참조 파일

| 파일 | 역할 |
|------|------|
| `Lit_Review_Citation_Matrix_v2.xlsx` | **마스터 엑셀** — 16컬럼 양식 + 필러-키워드 매핑 |
| `templates/lit-review-template.md` | 16컬럼 구조 명세 |
| `templates/citation-template.md` | 인용 추출 형식 (Strict Verbatim + 인용 유형 4종) |
| `templates/preprocess-prompt.md` | PDF→JSON 전처리 프롬프트 |
| `projects/<프로젝트명>.md` | 프로젝트별 맥락 (Pillar, 키워드, 연구 주제) |

## 필러-키워드 매핑 (엑셀 2번째 시트)

논문 분석 시 자동으로 Pillar와 검색 키워드를 매칭합니다:

| Pillar | 테마 | ID 접두어 예시 |
|--------|------|---------------|
| Pillar A | Desirable Difficulty | PA-DD, PA-ML, PA-FR, PA-PF, PA-EA, PA-SM |
| Pillar B | AI Teammate 패러다임 | PB-AT, PB-SM, PB-CS, PB-EG, PB-DA |
| Pillar C | 문화적 방패 (AIED) | PC-CI, PC-GT, PC-FS, PC-CE |
| Pillar D | 인과적 개입과 주체성 | PD-CT, PD-HA, PD-IH, PD-XA |

## 하위 기능 트리

Director가 입력과 요청을 분석하여 자동 선택합니다:

| 하위 기능 | 트리거 조건 | 내부 레퍼런스 |
|-----------|------------|--------------|
| PDF 전처리 | PDF 입력 시 자동 실행 | `commands/internal/preprocess.md` |
| 단일 논문 정밀 인용 | PDF 1개 + 인용 중심 요청 | `commands/internal/cite.md` |
| 단일 논문 종합 분석 | PDF 1개 + 종합 분석 요청 | `commands/internal/analyze.md` |
| 문헌 리뷰 종합 | 기존 분석 결과 종합 요청 | `commands/internal/review.md` |
| 엑셀 내보내기 | xlsx/csv 내보내기 요청 | `commands/internal/export.md` |

## 자동 판단 기준

1. **입력이 PDF 파일 1개**:
   - 요청에 "인용", "cite", "정밀 인용", "인용구" 키워드 → **단일 논문 정밀 인용**
   - 그 외 (분석, 요약, 평가 등) → **단일 논문 종합 분석**

2. **파일 입력 없이 종합 요청**:
   - "리뷰", "종합", "정리", "review" 키워드 → **문헌 리뷰 종합**
   - "내보내기", "export", "xlsx", "엑셀" 키워드 → **엑셀 내보내기**

3. **판단이 애매한 경우**: 기본값은 **단일 논문 종합 분석** (파일 있을 때) 또는 **문헌 리뷰 종합** (파일 없을 때)

## 실행 절차

### Phase 0: PDF 전처리 (PDF 입력 시 자동 실행)

PDF 파일이 입력된 경우, 분석 전에 반드시 전처리를 수행합니다.
`commands/internal/preprocess.md`의 로직을 따릅니다:

1. `output/<프로젝트>/preprocessed/<논문명>.json` 캐시 확인
   - 이미 존재 → 전처리 스킵, 캐시된 JSON 사용
   - 미존재 → 전처리 실행
2. PDF를 **20페이지 단위 청크**로 분할
3. 각 청크를 `templates/preprocess-prompt.md` 프롬프트와 함께 Task(Gadfly Literature Analyst)에 전달
4. 청크별 JSON 결과를 병합하여 최종 JSON 저장
5. 이후 Phase 1~3에서는 **전처리된 JSON만 사용** (PDF 원본 다시 읽지 않음)

### Phase 1: Director — 입력 분석 및 라우팅

1. 입력 유형을 확인합니다:
   - PDF 파일 경로 → Phase 0 전처리 결과(JSON) 확인
   - 파일 없음 → 기존 분석 결과 기반 작업
2. `projects/<프로젝트명>.md`를 읽어 프로젝트 맥락을 파악합니다.
3. `Lit_Review_Citation_Matrix_v2.xlsx`의 `필러-키워드 매핑` 시트를 참조하여 Pillar/키워드를 매칭합니다.
4. `templates/lit-review-template.md`를 읽어 16컬럼 출력 양식을 확인합니다.
5. `templates/citation-template.md`를 읽어 인용 추출 형식을 확인합니다.
6. 자동 판단 기준에 따라 하위 기능을 선택합니다.

### Phase 2: 하위 기능 실행

#### A. 단일 논문 정밀 인용 (`commands/internal/cite.md`)

- 전처리 JSON 기반 정밀 인용 추출
- 인용 유형 4종 분류 (근거/대조/Gap/방법론참조)
- **1인용 = 1행** Citation Matrix 테이블 출력

#### B. 단일 논문 종합 분석 (`commands/internal/analyze.md`)

- 다중 전문가 병렬 분석
- Citation Matrix 테이블 + 전문가 심층 분석 부록
- Literature Review 서술 전략 제안 포함

#### C. 문헌 리뷰 종합 (`commands/internal/review.md`)

- 기존 분석 결과 종합
- Pillar별 연구 동향 정리
- 통합 Citation Matrix + 연구 갭 분석

#### D. 엑셀 내보내기 (`commands/internal/export.md`)

- 분석 결과를 `Lit_Review_Citation_Matrix_v2.xlsx`에 직접 추가
- 기존 데이터 보존, 신규 행만 추가
- openpyxl로 엑셀 직접 작성

### Phase 3: Director — 결과 저장 및 보고

- 전처리 결과: `output/<프로젝트>/preprocessed/<논문명>.json`
- 인용 추출: `output/<프로젝트>/cite-[약칭]-YYYY-MM-DD.md`
- 종합 분석: `output/<프로젝트>/analyze-[약칭]-YYYY-MM-DD.md`
- 리뷰 종합: `output/<프로젝트>/review-YYYY-MM-DD.md`
- 엑셀: `Lit_Review_Citation_Matrix_v2.xlsx`

터미널에 기본 정보 + 인용 유형 분포 + 저장 경로를 출력합니다.
