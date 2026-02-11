# 검색 전략 (Search Strategies)

## 핵심 개념

### 학술 데이터베이스별 검색 가이드
| DB | 분야 | 특성 | 검색 팁 |
|----|------|------|---------|
| ERIC | 교육학 | 교육학 최대 DB, 시소러스(Thesaurus) 제공 | ERIC Descriptors 활용, 교육학 전용 용어 |
| Scopus | 종합(다학제) | 최대 규모 초록/인용 DB, 인용 분석 강점 | 저자 ID, 기관 검색, 인용 추적 |
| Web of Science | 종합(다학제) | SSCI/SCI/A&HCI, 영향력 지수(IF) 제공 | Cited Reference Search, 인용 네트워크 |
| PubMed | 의학/생명과학 | MeSH(Medical Subject Headings) 시소러스 | MeSH 용어 활용, Clinical Queries 필터 |
| RISS | 한국 종합 | 학위논문/학술지/단행본 통합 검색 | 한국 학위논문 유일 통합 DB, 원문 제공 |
| KCI | 한국 학술지 | 한국연구재단 등재지/등재후보지 | KCI 인용지수, 등재 학술지 필터 |
| DBPIA | 한국 학술지 | 한국 학술지 원문 제공 | 주제별 분류 브라우징, 학술지별 검색 |
| Google Scholar | 종합(무료) | 범위 넓음, 인용 추적 용이 | 고급 검색, "Cited by" 활용, Alerts 설정 |

### 검색 연산 기법 (Search Operators)
| 연산 | 기능 | 예시 |
|------|------|------|
| AND | 모든 용어 포함 | "artificial intelligence" AND education |
| OR | 하나 이상 포함 | "machine learning" OR "deep learning" |
| NOT | 특정 용어 배제 | AI NOT "artificial insemination" |
| 절단 검색(*) | 어근 기반 확장 | teach* → teaching, teacher, teaches |
| 구문 검색("") | 정확한 구문 매칭 | "self-regulated learning" |
| 근접 검색(NEAR, W/n) | 단어 간 거리 지정 | AI NEAR/3 education (3단어 이내) |
| 괄호 () | 연산 우선순위 지정 | (AI OR "artificial intelligence") AND education |

### 한국 DB 특수 검색 특성
- **RISS**: 통합검색 시 학위논문/학술지/단행본 필터 필수, 상세 검색에서 지도교수/학위수여기관 검색 가능
- **KCI**: 등재지/등재후보지 필터, KCI 인용지수 확인, 피인용 횟수 정렬
- **DBPIA**: Boolean 연산 제한적, 주제 분류(대분류/중분류) 브라우징 유용
- **한국 DB 공통 한계**: 영문 초록 검색 정확도 낮음, 시소러스 부재, 검색 연산 제한적

## 주요 프레임워크

### PRISMA 흐름도 (체계적 문헌 고찰)
```
1. 식별(Identification)
   - DB 검색 결과 총 수 + 기타 출처(스노우볼링 등)
   - 중복 제거 후 문헌 수
         ↓
2. 스크리닝(Screening)
   - 제목/초록 기반 1차 스크리닝
   - 배제 문헌 수 및 사유
         ↓
3. 적격성(Eligibility)
   - 전문(Full-text) 검토
   - 배제 문헌 수 및 구체적 사유
         ↓
4. 포함(Inclusion)
   - 최종 분석 대상 문헌 수
   - (메타분석 시) 양적 합성 대상 문헌 수
```

### 스노우볼링 (Snowballing)
- **후방 스노우볼링(Backward)**: 핵심 문헌의 참고문헌 목록 추적 → 선행 문헌 발굴
- **전방 스노우볼링(Forward)**: 핵심 문헌을 인용한 후속 문헌 추적 (Cited by 기능)
- **활용 시점**: DB 검색 후 보완적 수행, 핵심 문헌(Seminal work) 기점
- **도구**: Google Scholar "Cited by", Scopus "Citing articles", Web of Science "Cited References"

### 검색 전략 수립 절차
1. **연구 질문 분해**: PICO(참여자-중재-비교-결과) 또는 PCC(참여자-개념-맥락)로 핵심 요소 추출
2. **검색어 개발**: 각 요소별 동의어/유의어/상위어/하위어 나열
3. **Boolean 조합**: 요소 내 OR, 요소 간 AND 조합
4. **DB별 실행**: 각 DB 인터페이스에 맞게 검색식 조정
5. **결과 검토 및 수정**: 적합성 비율(Precision) 확인, 검색식 반복 수정
6. **문서화**: 검색일, DB, 검색식, 결과 수 기록 (PRISMA 요구사항)

### DB별 필터 조건
| 필터 | ERIC | Scopus | WoS | PubMed | RISS | KCI |
|------|------|--------|-----|--------|------|-----|
| 출판 연도 | O | O | O | O | O | O |
| 언어 | O | O | O | O | 제한적 | X |
| 문서 유형 | O | O | O | O | O | 제한적 |
| 피어리뷰 | O | O | O | O | X | 등재지 필터 |
| 전문 접근 | 부분 | 기관구독 | 기관구독 | 무료(PubMed Central) | 부분 무료 | 무료 |

## 비판적 관점
- 영어 편향(English Bias): 영어 DB 중심 검색은 비영어권 연구를 체계적으로 배제
- 한국어 문헌 검색의 구조적 한계: 시소러스 부재, 메타데이터 불일치, DB 간 중복
- 회색 문헌(Grey Literature)의 체계적 포함 필요성: 학위논문, 보고서, 학회 발표
- 출판 편향(Publication Bias): 유의미한 결과 중심의 출판 경향
- AI 기반 문헌 검색 도구(Semantic Scholar, Elicit, Connected Papers)의 가능성과 한계

## 용어 사전
| 영어 | 한국어 | 설명 |
|------|--------|------|
| Boolean Operators | 불리언 연산자 | AND, OR, NOT을 활용한 논리적 검색 조합 |
| Truncation | 절단 검색 | 어근에 와일드카드(*)를 사용한 검색 확장 |
| PRISMA | 체계적 고찰 보고 지침 | 체계적 문헌 고찰의 투명한 보고를 위한 가이드라인 |
| Snowballing | 스노우볼링 | 핵심 문헌의 인용 관계를 추적하는 문헌 탐색 기법 |
| Grey Literature | 회색 문헌 | 상업 출판 경로 외의 비공식 학술 자료 |
| Thesaurus | 시소러스 | DB의 표준화된 통제 어휘 체계 |
| Seminal Work | 핵심 문헌 | 특정 분야에서 기초가 되는 선구적 연구 |
| Precision/Recall | 정확률/재현율 | 검색 결과의 적합성과 포괄성 지표 |
