# 온톨로지 기초 (Ontology Fundamentals)

## 핵심 개념

### 온톨로지란?
- 특정 도메인의 개념과 그 관계를 형식적으로 명세한 것
- 지식 표현(Knowledge Representation)의 핵심 도구
- 기계와 사람 모두가 이해할 수 있는 공유 어휘 체계

### RDF 트리플 (Subject - Predicate - Object)
```
예시:
- (AI_Teammate, is_a, Collaborative_Agent)
- (Cognitive_Friction, caused_by, AI_Socratic_Questioning)
- (Social_Shield, mitigates, Face_Saving_Pressure)
```

### 주요 관계 유형
| 관계 | 영어 | 설명 | 예시 |
|------|------|------|------|
| 상위/하위 | is_a | 분류 관계 | AI_Tutor is_a AI_Agent |
| 부분-전체 | part_of | 구성 관계 | Stage_1 part_of Two_Stage_Model |
| 인과 | causes | 원인-결과 | Friction causes Deep_Thinking |
| 활성화 | enables | 가능하게 함 | Shield enables Free_Critique |
| 완화 | mitigates | 문제 완화 | Shield mitigates Face_Loss |
| 요구 | requires | 전제 조건 | Teammate requires SMM |
| 대립 | opposes | 반대/갈등 | Tool_View opposes Teammate_View |

### 온톨로지 수준
- **상위 온톨로지(Upper Ontology)**: 도메인 독립적 일반 개념 (예: SUMO, BFO)
- **도메인 온톨로지(Domain Ontology)**: 특정 분야의 개념 체계
- **응용 온톨로지(Application Ontology)**: 특정 응용을 위한 세부 명세

### 교육/정보학 분야 표준 온톨로지
- **IEEE LOM**: 학습 객체 메타데이터
- **Dublin Core**: 범용 메타데이터 요소
- **FOAF**: 사람과 관계 기술
- **SKOS**: 지식 조직 체계 표현

## 연구 기획에의 활용

### 개념 맵 구축
1. 논문에서 핵심 개념 추출
2. 개념 간 관계를 트리플로 표현
3. 트리플을 트리/그래프 구조로 시각화
4. 관계 부재 = 연구 갭 식별

### 선행연구 전략 수립
1. 온톨로지 맵에서 탐색 영역 식별
2. 각 개념에 해당하는 검색 키워드 도출
3. 관계 유형에 따른 검색 우선순위 결정
4. 미연결 개념 = 추가 탐색 필요 영역

## 용어 사전
| 영어 | 한국어 | 설명 |
|------|--------|------|
| Ontology | 온톨로지 | 개념과 관계의 형식적 명세 |
| RDF Triple | RDF 트리플 | 주어-술어-목적어 형태의 지식 표현 |
| Knowledge Graph | 지식 그래프 | 개체와 관계로 구성된 그래프 구조 |
| Taxonomy | 분류 체계 | 계층적 분류 구조 |
| Thesaurus | 시소러스 | 통제어휘의 의미 관계 체계 |
