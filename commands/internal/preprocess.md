---
allowed-tools: Read, Glob, Grep, Task, Write, Bash
description: PDF를 텍스트 기반 JSON으로 전처리한다. 20페이지 청크 분할 → Claude API 추출 → 병합 저장.
---

# /gadfly-preprocess

PDF 논문을 텍스트 기반 JSON으로 변환하는 전처리 단계입니다. API의 이미지/문서 수 제한(100개)을 우회하고, 이후 분석 단계에서 텍스트로만 작업할 수 있게 합니다.

## 사용법

이 명령은 직접 호출하지 않습니다. `gadfly-litreview` 라우터가 cite/analyze 실행 전에 자동으로 호출합니다.

## 실행 절차

### Step 1: 캐시 확인

1. `output/<프로젝트>/preprocessed/` 폴더에 해당 논문의 JSON 파일이 이미 존재하는지 확인합니다.
   - 파일명 규칙: `<논문파일명에서 확장자 제거>.json`
   - 예: `paper-abc.pdf` → `output/<프로젝트>/preprocessed/paper-abc.json`
2. **이미 존재하면 → 전처리 스킵**, JSON 경로를 반환합니다.
3. 존재하지 않으면 → Step 2로 진행합니다.

### Step 2: PDF 정보 확인

1. PDF 파일을 Read 도구로 열어 총 페이지 수를 파악합니다.
2. 20페이지 단위로 청크를 계획합니다:
   - 1~20페이지 → 청크 1
   - 21~40페이지 → 청크 2
   - ...
   - 남은 페이지 → 마지막 청크

```
전처리 대상: paper-abc.pdf (총 85페이지)
청크 계획: 5개 (20, 20, 20, 20, 5페이지)
```

### Step 3: 청크별 텍스트 추출

각 청크에 대해 **순차적으로** 다음을 실행합니다:

1. Read 도구로 해당 페이지 범위의 PDF를 읽습니다 (`pages` 파라미터 활용).
2. `templates/preprocess-prompt.md`의 프롬프트와 함께 **Task(Gadfly Literature Analyst)**를 호출합니다.
3. Task 프롬프트 구성:

```
당신은 학술 논문 분석 전문가입니다.

[templates/preprocess-prompt.md의 프롬프트 내용 전달]

현재 분석 대상: 청크 {N}/{총 청크 수} (P.{시작}~P.{끝})

다음은 해당 페이지들의 내용입니다:
[Read 도구로 읽은 PDF 페이지 내용]

위 내용을 분석하여 JSON 형식으로 출력해주세요.
JSON만 출력하고, 다른 텍스트는 출력하지 마세요.
```

4. 반환된 JSON을 파싱하여 저장합니다.
5. 진행 상황을 보고합니다: `[청크 2/5] P.21~40 추출 완료`

### Step 4: 청크 병합

`templates/preprocess-prompt.md`의 **청크 병합 규칙**에 따라 결과를 통합합니다:

1. **metadata**: 첫 번째 청크의 메타데이터를 기본값으로 사용. 이후 청크에서 누락 필드를 보완.
2. **sections**: 모든 청크의 섹션을 순서대로 합산.
   - 동일 섹션이 청크 경계에 걸칠 경우: content를 이어붙이고, page_end를 갱신하고, key_points를 합산.
3. **figures**: 모든 청크의 figures를 합산. id 중복 시 나중 청크 우선.
4. **tables**: 모든 청크의 tables를 합산. id 중복 시 나중 청크 우선.

병합된 최종 JSON 구조:

```json
{
    "source_file": "원본 PDF 경로",
    "preprocessed_at": "YYYY-MM-DDTHH:MM:SS",
    "total_pages": 85,
    "chunks_processed": 5,
    "metadata": { ... },
    "sections": [ ... ],
    "figures": [ ... ],
    "tables": [ ... ]
}
```

### Step 5: 저장 및 반환

1. `output/<프로젝트>/preprocessed/` 폴더가 없으면 생성합니다.
2. 병합된 JSON을 `output/<프로젝트>/preprocessed/<논문명>.json`으로 저장합니다.
3. 저장 경로를 반환합니다.

```
전처리 완료: paper-abc.pdf
  - 총 85페이지 → 5개 청크 처리
  - 섹션 8개, 그림 12개, 표 5개 추출
  - 저장: output/my-project/preprocessed/paper-abc.json
```

## 오류 처리

- **청크 파싱 실패**: 해당 청크의 JSON이 유효하지 않으면 1회 재시도합니다. 재시도 실패 시 해당 청크를 빈 결과로 처리하고 경고를 출력합니다.
- **PDF 읽기 실패**: 파일 경로/형식 오류를 보고하고 중단합니다.
