# PDF 전처리 프롬프트 (Preprocess Prompt)

> PDF 청크를 텍스트 기반 JSON으로 변환하는 전처리 프롬프트입니다.
> 각 청크(20페이지 단위)에 대해 이 프롬프트를 적용합니다.
> **목적**: Literature Review 작성을 위한 정밀 인용 추출의 전 단계.

## 프롬프트

당신은 학술 논문 분석 전문가입니다.

첨부된 PDF 페이지들을 분석하여 다음 정보를 JSON 형식으로 추출해주세요.
이 데이터는 Literature Review의 Citation Matrix 작성에 활용됩니다.
반드시 전체를 꼼꼼히 읽고, **원문 텍스트를 누락 없이** 추출해야 합니다.

### 1. 메타데이터 (metadata)
- title: 논문 제목 (원문 그대로)
- authors: 저자 목록 — APA 형식으로 정리 (예: "Ouyang & Zhang (2024)")
- abstract: 초록 전문
- keywords: 키워드 목록
- publication_date: 출판 연도
- journal: 학회/저널명 (볼륨, 호, 페이지 포함)
- doi: DOI (있는 경우)
- language: 논문 언어 (ko, en 등)

### 2. 섹션 구조 (sections)
논문의 각 섹션에 대해 다음을 추출해주세요:
- type: 섹션 유형 (title, abstract, introduction, literature_review, methodology, results, discussion, conclusion, references, appendix, other 중 하나)
- title: 섹션 제목 (원문 그대로)
- page_start: 시작 페이지 번호
- page_end: 끝 페이지 번호
- content: 해당 섹션의 **전문 텍스트** (원문 그대로, 누락 없이. 인용 추출의 원본이 됩니다)
- key_points: 해당 섹션의 핵심 포인트 3~5개 (한 문장씩, 구체적으로)

### 3. 이미지/그림 분석 (figures)
논문에 포함된 모든 Figure에 대해:
- id: 식별자 (fig1, fig2...)
- page: 위치한 페이지 번호
- caption: 원문 캡션
- section: 소속 섹션 유형
- description: 이미지에 보이는 내용을 객관적으로 설명
- interpretation: 앞뒤 맥락을 고려한 해석. 이 이미지가 논문에서 어떤 주장이나 결과를 뒷받침하는지 구체적으로 설명
- category: 유형 (figure, chart, diagram, photo, other 중 하나)

### 4. 표 분석 (tables)
논문에 포함된 모든 Table에 대해:
- id: 식별자 (table1, table2...)
- page: 위치한 페이지 번호
- caption: 원문 캡션
- section: 소속 섹션 유형
- markdown: 표 내용을 마크다운 테이블로 재구성. 원본 데이터를 누락 없이 보존할 것
- summary: 표의 주요 내용 요약
- interpretation: 앞뒤 맥락을 고려한 해석. 이 표가 전달하는 핵심 메시지

### 5. 인용 후보 문장 (quotable_sentences)
Literature Review 작성에 직접 인용할 가치가 있는 핵심 문장들을 선별해주세요:
- text: 원문 문장 그대로 (Strict Verbatim)
- page: 페이지 번호
- location: 위치 (para.#, L.# 등)
- section: 소속 섹션 유형
- relevance: 이 문장이 왜 인용할 가치가 있는지 (1문장)

## 출력 JSON 스키마

```json
{
    "chunk_info": {
        "page_start": 1,
        "page_end": 20,
        "total_pages_in_chunk": 20
    },
    "metadata": {
        "title": "...",
        "authors": "Ouyang & Zhang (2024)",
        "abstract": "...",
        "keywords": ["...", "..."],
        "publication_date": "2024",
        "journal": "Educational Research Review, 44, 100616",
        "doi": "...",
        "language": "en"
    },
    "sections": [
        {
            "type": "introduction",
            "title": "1. Introduction",
            "page_start": 1,
            "page_end": 3,
            "content": "섹션 전문 텍스트 (원문 그대로)...",
            "key_points": ["...", "...", "..."]
        }
    ],
    "figures": [
        {
            "id": "fig1",
            "page": 5,
            "caption": "...",
            "section": "methodology",
            "description": "...",
            "interpretation": "...",
            "category": "chart"
        }
    ],
    "tables": [
        {
            "id": "table1",
            "page": 7,
            "caption": "...",
            "section": "results",
            "markdown": "| Column1 | Column2 |\n|---|---|\n| data1 | data2 |",
            "summary": "...",
            "interpretation": "..."
        }
    ],
    "quotable_sentences": [
        {
            "text": "원문 문장 그대로",
            "page": 6,
            "location": "para.2",
            "section": "results",
            "relevance": "인지적 참여 편중 현상을 구체적 수치로 제시"
        }
    ]
}
```

## 청크 병합 규칙

여러 청크의 결과를 병합할 때:
1. **metadata**: 첫 번째 청크(표지/초록 포함)의 메타데이터를 기본값으로 사용. 이후 청크에서 보완.
2. **sections**: 모든 청크의 섹션을 합산. 동일 섹션이 청크 경계에 걸칠 경우 content를 이어붙이고 page_end를 갱신.
3. **figures**: 모든 청크의 figures를 합산. id 중복 시 나중 청크의 것을 우선.
4. **tables**: 모든 청크의 tables를 합산. id 중복 시 나중 청크의 것을 우선.
5. **quotable_sentences**: 모든 청크의 인용 후보를 합산. 중복 제거.

## 주의사항

1. **Strict Verbatim**: sections의 content와 quotable_sentences의 text는 원문 텍스트를 한 글자도 변경하지 않고 그대로 보존해야 합니다. 이 텍스트가 나중에 Literature Review의 직접 인용구(Direct Quote)로 사용됩니다.
2. **이미지 해석 필수**: 이미지는 텍스트로 변환 후에는 접근 불가하므로, description과 interpretation을 충분히 상세하게 작성합니다.
3. **표 마크다운 변환 필수**: 표 데이터 역시 텍스트 변환 후 원본에 접근 불가하므로, markdown 필드에 모든 데이터를 보존합니다.
4. **참고문헌 섹션**: references 섹션은 content에 전체 참고문헌 목록을 포함합니다.
5. **저자 형식**: metadata.authors는 APA 형식으로 정리합니다 (예: "Kim & Lee (2024)", "Ouyang et al. (2023)").
