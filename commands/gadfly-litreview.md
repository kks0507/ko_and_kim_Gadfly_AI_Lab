---
allowed-tools: Read, Glob, Grep, Task, Write, Bash
description: 문헌 고찰 통합. 단일 논문 인용/분석, 일괄 분석, 리뷰 종합, 내보내기를 자동 판단하여 실행한다.
---

# /gadfly-litreview — 문헌 고찰

문헌 고찰의 모든 과정을 통합 지원합니다. Director가 입력 유형과 요청 의도를 분석하여 적합한 하위 기능을 자율적으로 선택·실행합니다.

## 사용법

```
/gadfly-litreview <논문.pdf> --project <프로젝트명>
/gadfly-litreview <논문폴더/> --project <프로젝트명>
/gadfly-litreview --project <프로젝트명>
/gadfly-litreview --project <프로젝트명> --export csv
```

## 하위 기능 트리

Director가 입력과 요청을 분석하여 자동 선택합니다:

| 하위 기능 | 트리거 조건 | 배치 에이전트 | 내부 레퍼런스 |
|-----------|------------|-------------|--------------|
| 단일 논문 정밀 인용 | PDF 1개 + 인용 중심 요청 | literature-analyst | `commands/internal/cite.md` |
| 단일 논문 종합 분석 | PDF 1개 + 종합 분석 요청 | literature-analyst + planning + (methodology, data-analyst) | `commands/internal/analyze.md` |
| 일괄 논문 분석 | 폴더/다수 PDF 입력 | literature-analyst + planning + ... | `commands/internal/batch.md` |
| 문헌 리뷰 종합 | 기존 분석 결과 종합 요청 | planning + literature-analyst | `commands/internal/review.md` |
| 결과 내보내기 | CSV/마크다운 내보내기 요청 | (Director only) | `commands/internal/export.md` |

## 자동 판단 기준

Director는 다음 기준으로 하위 기능을 판단합니다:

1. **입력이 PDF 파일 1개**:
   - 요청에 "인용", "cite", "정밀 인용", "인용구" 키워드 → **단일 논문 정밀 인용**
   - 그 외 (분석, 요약, 평가 등) → **단일 논문 종합 분석**

2. **입력이 폴더 또는 다수 파일**:
   - → **일괄 논문 분석**

3. **파일 입력 없이 종합 요청**:
   - "리뷰", "종합", "정리", "review" 키워드 → **문헌 리뷰 종합**
   - "내보내기", "export", "CSV", "마크다운" 키워드 → **결과 내보내기**

4. **판단이 애매한 경우**: 기본값은 **단일 논문 종합 분석** (파일 있을 때) 또는 **문헌 리뷰 종합** (파일 없을 때)

## 실행 절차

### Phase 1: Director — 입력 분석 및 라우팅

1. 입력 유형을 확인합니다:
   - 파일 경로 → Read로 파일 존재 확인, PDF인지 폴더인지 판단
   - 폴더 경로 → Glob으로 내부 파일 스캔
   - 파일 없음 → 기존 분석 결과 기반 작업
2. `projects/<프로젝트명>.md`를 읽어 프로젝트 맥락을 파악합니다.
3. `templates/lit-review-template.md`를 읽어 출력 양식을 확인합니다.
4. `templates/citation-template.md`를 읽어 인용 형식을 확인합니다.
5. 자동 판단 기준에 따라 하위 기능을 선택합니다.

### Phase 2: 하위 기능 실행

선택된 하위 기능에 따라 해당 내부 레퍼런스의 로직을 실행합니다.

#### A. 단일 논문 정밀 인용 (`commands/internal/cite.md` 참조)

1. 논문 메타데이터 추출 (제목, 저자, 학술지, DOI, 섹션 구조)
2. **문헌분석가(gadfly-literature-analyst)**에게 정밀 인용 추출 지시:
   - 프로젝트 키워드·이론·비판 프레임 전달
   - `templates/citation-template.md` 형식 준수
   - 인용 통합 기법 제안 (패러프레이즈 vs 직접 인용)
   - 방법론적 품질 평가
3. Lit Review 양식으로 출력

#### B. 단일 논문 종합 분석 (`commands/internal/analyze.md` 참조)

1. 논문 메타데이터 추출
2. 필요한 전문가를 판단하여 **병렬 배치**:
   - **문헌분석가(gadfly-literature-analyst)**: 정밀 인용 추출 (필수)
   - **기획전문가(gadfly-planning)**: 온톨로지 구조화 (필수)
   - **방법론전문가(gadfly-methodology)**: 방법론 평가 (권장)
   - **데이터분석가(gadfly-data-analyst)**: 결과/통계 평가 (권장)
3. 전문가 결과 통합 → Lit Review 양식 출력

#### C. 일괄 논문 분석 (`commands/internal/batch.md` 참조)

1. 폴더 스캔 → 파일 목록 정리
2. 각 논문에 대해 종합 분석 로직을 순차 실행
3. 종합 비교 매트릭스 생성:
   - 논문 간 공통 키워드/이론 교차점
   - 방법론 분포
   - 연구 갭 패턴
   - 통합 온톨로지 맵
4. 개별 CSV 데이터 + 종합 보고서 출력

#### D. 문헌 리뷰 종합 (`commands/internal/review.md` 참조)

1. `output/<프로젝트>/` 폴더의 기존 분석 결과 스캔
2. **기획전문가(gadfly-planning)**: 개념 온톨로지 통합, 논문 간 관계 식별
3. **문헌분석가(gadfly-literature-analyst)**: 킬러 인용구 선별
4. 종합 리뷰 보고서 출력:
   - 연구 동향, 이론적 프레임워크 분류, 방법론 비교
   - 통합 온톨로지 맵, 연구 갭 분석
   - 킬러 인용구 목록, 후속 연구 제안

#### E. 결과 내보내기 (`commands/internal/export.md` 참조)

1. `output/<프로젝트>/` 폴더의 분석 결과 수집
2. Lit Review 양식 데이터 추출
3. CSV 및/또는 마크다운 테이블로 내보내기
4. 저장 경로 및 요약 출력

### Phase 3: Director — 결과 저장 및 보고

- 개별 분석 결과: `output/<프로젝트>/cite-*.md` 또는 `output/<프로젝트>/analyze-*.md`
- 일괄 분석: `output/<프로젝트>/batch-YYYY-MM-DD/`
- 리뷰 종합: `output/<프로젝트>/review-YYYY-MM-DD.md`
- 내보내기: `output/<프로젝트>/lit-review-YYYY-MM-DD.csv` / `.md`

터미널에 기본 정보 + 분석 요약 + 저장 경로를 출력합니다.
