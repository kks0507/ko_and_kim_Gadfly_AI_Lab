---
allowed-tools: Read, Glob, Grep, Write, Bash
description: 분석 결과를 Lit_Review_Citation_Matrix_v2.xlsx 엑셀 양식에 맞춰 내보낸다. openpyxl로 직접 xlsx 작성.
---

# /gadfly-export

프로젝트의 분석 결과를 `Lit_Review_Citation_Matrix_v2.xlsx`의 16컬럼 양식에 맞춰 엑셀 파일로 내보냅니다.

## 사용법

```
/gadfly-export --project <프로젝트명>
/gadfly-export --project <프로젝트명> --format xlsx
/gadfly-export --project <프로젝트명> --format csv
/gadfly-export --project <프로젝트명> --format both
```

기본값: `--format xlsx`

## 실행 절차

### Phase 1: 데이터 수집

1. `output/<프로젝트>/` 폴더의 모든 분석 결과(cite-*.md, analyze-*.md)를 스캔합니다.
2. 각 논문의 분석 결과에서 16컬럼 데이터를 추출합니다.
3. `templates/lit-review-template.md`를 참조하여 컬럼 구조를 확인합니다.
4. `Lit_Review_Citation_Matrix_v2.xlsx`의 `필러-키워드 매핑` 시트를 참조하여 ID 접두어를 확인합니다.

### Phase 2: 엑셀 파일 작성 (--format xlsx 또는 both)

Bash 도구로 Python 스크립트를 실행하여 `openpyxl`로 엑셀 파일을 직접 작성합니다.

**엑셀 구조**:

#### Sheet 1: Lit Review Matrix

**Row 1 (카테고리 헤더)**:
```
A1: 필러 연결 | C1: 기본 정보 | G1: 핵심 내용 | J1: 정밀 인용 | M1: 비평 및 연결 | O1: 관리 상태
```

**Row 2 (컬럼 헤더)**:
```
A2: Pillar
B2: 검색 키워드
C2: ID / 분류
D2: 저자 (연도)
E2: 논문 제목
F2: 학술지/출처
G2: 연구 목적
H2: 연구 방법론
I2: 주요 결과 (요약)
J2: 핵심 인용구 (Direct Quote)
K2: 출처 위치 (p.#, L.#)
L2: 인용 유형
M2: 핵심 키워드
N2: 한계점/후속연구
O2: 진행 상태
P2: 파일 링크
```

**Row 3~**: 데이터 행 (1인용 = 1행)

**셀 병합**: Row 1의 카테고리 헤더는 해당 컬럼 범위를 병합합니다:
- A1:B1 = 필러 연결
- C1:F1 = 기본 정보
- G1:I1 = 핵심 내용
- J1:L1 = 정밀 인용
- M1:N1 = 비평 및 연결
- O1:P1 = 관리 상태

**기존 데이터 보존**: `Lit_Review_Citation_Matrix_v2.xlsx`에 이미 데이터가 있으면, 기존 행을 유지하고 새 분석 결과만 추가합니다. ID가 중복되면 덮어쓰지 않고 경고합니다.

#### Sheet 2: 필러-키워드 매핑 (기존 유지)

기존 `Lit_Review_Citation_Matrix_v2.xlsx`의 `필러-키워드 매핑` 시트를 그대로 복사합니다.

#### Sheet 3: 이용 가이드 (기존 유지)

기존 `Lit_Review_Citation_Matrix_v2.xlsx`의 `이용 가이드` 시트를 그대로 복사합니다.

저장 경로: `Lit_Review_Citation_Matrix_v2.xlsx` (원본 파일에 직접 추가)

### Phase 3: CSV 생성 (--format csv 또는 both)

CSV 칼럼 구조 (엑셀 Row 2와 동일):
```
Pillar,검색 키워드,ID / 분류,저자 (연도),논문 제목,학술지/출처,연구 목적,연구 방법론,주요 결과 (요약),핵심 인용구 (Direct Quote),출처 위치 (p.#; L.#),인용 유형,핵심 키워드,한계점/후속연구,진행 상태,파일 링크
```

저장 경로: `output/<프로젝트>/lit-review-YYYY-MM-DD.csv`

### Phase 4: 결과 보고

```
내보내기 완료:
  - 총 논문 수: N편
  - 총 인용구 수: M개 (N편 × 평균 인용수)
  - 엑셀 저장: Lit_Review_Citation_Matrix_v2.xlsx
  - CSV 저장: output/<프로젝트>/lit-review-YYYY-MM-DD.csv (해당 시)
  - 기존 행 유지: X행, 신규 추가: Y행
```
