# Biblo Ontology Architecture & Service Design Constitution

> FRBR 기반 Unified Knowledge Platform 인수인계서
> 설립자의 암묵지(Tacit Knowledge)로서, 기획전문가의 온톨로지 설계 철학의 근간이 된다.

## 0. 문서 목적

이 문서는 Biblo 플랫폼의 핵심 설계 원리인 **FRBR 기반 Ontology 구조**와 **Ontology-driven 서비스 기획 방식**을 정의한다.

Biblo는 단순한 도서 검색 시스템이 아니다.

> **Biblo = Ontology 기반 AI Knowledge Platform**

**Ontology 이해 없이 구조 변경 금지.** 이는 기능 오류가 아니라 아키텍처 붕괴로 이어질 수 있다.

## 1. Biblo 설계 철학 (Architecture Philosophy)

### 근본 원칙

> 우리는 데이터를 저장하지 않는다.
> 우리는 **'지식 구조'를 설계**한다.

일반 서비스 구조:
```
DB → API → Feature
```

Biblo 구조:
```
Ontology → AI Reasoning → Service → DB
```

**Ontology가 운영체제(OS) 역할을 한다.**

### 한 줄 정의

> "Biblo는 책을 관리하는 시스템이 아니라 **지식 간 관계를 설계하는 AI 플랫폼**이다."

## 2. FRBR 기반 Ontology 구조

Biblo의 모든 서비스는 아래 구조 위에서 설계된다.

### FRBR Core Model
```
Work
 → Expression
   → Manifestation
     → Item
```

Biblo는 FRBR을 도서관 관리 모델로 사용하지 않는다. **AI Knowledge Ontology로 확장한다.**

## 3. FRBR 실제 샘플 — 『어린 왕자』

### Work — 지식의 원자 단위
```
Work_ID: W-000001
Title: 어린 왕자
Author: Antoine de Saint-Exupéry

Core Concepts:
- 존재
- 관계
- 사랑
- 순수성
- 상실

Semantic Category:
- 철학적 우화
- 인간관계 탐구
- 성장 서사
```

**가장 중요한 규칙:**
> Work는 "책"이 아니다.
> **Semantic Knowledge Object**이다.
> ISBN보다 상위 개념이다.

### Expression — 의미는 같지만 표현이 다른 형태
```
E-01 : French Original
E-02 : English Translation
E-03 : Korean Translation
E-04 : Children's Edition
```

- 의미 동일, 언어/표현만 다름
- **추천 정확도 상승의 핵심 구조**

### Manifestation — 출판 단위 (ISBN 등장)
```
M-01 : 민음사 2000
M-02 : 열린책들 2015
M-03 : Penguin Classics
```

> ISBN은 Ontology의 중심이 아니다. **Work가 중심이다.**

### Item — 현실 세계 상태 데이터
```
SKKU : Available
SNU : Checked-out
Yonsei : Not Owned
```

- 상태 정보일 뿐. Ontology Core가 아니다.
- (신입이 가장 많이 착각하는 영역)

## 4. Biblo 확장 Ontology (Critical Layer)

FRBR 위에 **Semantic Layer**를 추가한다.

```
Work
 ├ semantic_embedding
 ├ topic_graph
 ├ emotion_vector
 ├ related_works
 ├ reader_persona_links
```

이 구조가 만들어지는 순간:
```
Biblo = Library System ❌
Biblo = AI Knowledge Graph Platform ✅
```

## 5. Central Master Ontology 전략

### 절대 금지: 학교별 DB 구축

이유:
- 데이터 파편화
- AI 학습 불가
- 추천 품질 하락
- 운영 비용 증가

### Biblo 구조
```
Central Master Ontology
        ↓
Institution Mapping
        ↓
Holding State (ON/OFF)
```

예시:
- Global Ontology: Work = 사피엔스
- SKKU: Not Owned
- 하지만 검색됨 → 희망도서 신청 버튼 활성화

### 결과
> Biblo는 도서관 시스템이 아니라 **Global Knowledge Catalog**.
> Netflix / Spotify와 동일한 데이터 전략.

## 6. Personal Schema Bridging (AI 핵심 엔진)

### 기존 검색 시스템의 오류
> "모든 사용자가 같은 개념 체계를 가진다." → **틀린 가정.**

### Biblo 관점
> 사람마다 세계 모델이 다르다.

예:
- 한국 학생: "효"
- 서구 학생: "family responsibility"
- 완전 동일하지 않다.

### 해결 구조
```
User Schema
   ↕ Alignment Layer
Ontology Concept
```

**Cognitive AI Architecture.** 단순 검색 기술이 아니다.

## 7. Ontology 기반 서비스 기획 Flow (Biblo Product Design Method)

> 이것이 Biblo 조직의 **표준 기획 방법론**이다.
> 기능부터 설계하는 기획자는 Biblo와 맞지 않는다.

### STEP 1 — Work 정의

절대 질문: **"이 기능이 어떤 Work / Knowledge Object를 다루는가?"**

예: 감정 추천 서비스 → 먼저 감정 Work 정의
```
Loneliness
Burnout
Relationship fatigue
```

### STEP 2 — Concept Extraction

Work가 가진 의미를 구조화한다.

```
Relationship fatigue
 → 인간관계
 → 존재 질문
 → 감정 소진
```

### STEP 3 — Ontology 연결

Concept → Work 매핑.
```
존재 → 어린 왕자
자아 탐색 → 데미안
삶의 의미 → 연금술사
```

여기까지 오면 이미 **추천 서비스 설계 80% 완료**.

### STEP 4 — Reasoning Path 설계

AI가 어떻게 추론할지 정의한다.
```
User Emotion
   ↓
Concept Mapping
   ↓
Work Cluster 탐색
```

→ hallucination 급감.

### STEP 5 — Service Interface 설계 (마지막 단계)

이제 UI / API 설계.

> 대부분 회사는 여기서 시작한다.
> **Biblo는 여기서 끝낸다.**

## 실제 사례: 감정 기반 추천 챗봇

사용자 입력: "요즘 인간관계가 너무 지쳐요."

Ontology 추론:
```
관계 피로
 → 존재 질문
 → 철학적 위로
```

추천 Work: 어린 왕자, 데미안, 연금술사

> 키워드 매칭 아님. **Concept Reasoning.**

### Commerce 확장 가능성
```
Work: 어린 왕자
자동 연결: 특별판, 굿즈, 필사 노트, 오디오북
```

> **Ontology = Commerce Engine.**

## 8. Biblo 설계 절대 원칙

| Rule | 원칙 |
|------|------|
| RULE 1 | **Work부터 정의하라.** |
| RULE 2 | Entity가 아니라 **Knowledge Object**로 설계하라. |
| RULE 3 | Local이 아니라 **Global 기준**으로 설계하라. |
| RULE 4 | Ontology는 DB가 아니다. **AI Reasoning Infrastructure**다. |

## Gadfly AI Lab 적용 원칙

이 Biblo 철학은 기획전문가의 온톨로지 설계에 다음과 같이 적용된다:

1. **논문 분석 시**: 논문의 핵심 개념을 Work(Semantic Knowledge Object)로 정의하고, 개념 간 관계를 Ontology로 구조화
2. **연구 기획 시**: 기능/방법론부터 시작하지 않고, Knowledge Object(연구 대상의 본질)부터 정의 → Concept 추출 → Ontology 연결 → Reasoning Path → 서비스/연구 설계
3. **Central Ontology 사상**: 프로젝트별 파편화가 아닌, 연구소 차원의 통합 지식 그래프 구축 지향
4. **Personal Schema Bridging**: 연구자마다 다른 개념 체계를 인정하고, Alignment Layer를 통해 Ontology와 연결
