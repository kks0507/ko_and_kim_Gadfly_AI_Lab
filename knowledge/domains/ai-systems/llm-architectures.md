# LLM 아키텍처 및 활용 패턴

## 핵심 개념

### LLM 활용 방식
- **Fine-tuning**: 특정 도메인/태스크에 모델을 추가 학습
- **Prompt Engineering**: 프롬프트 설계로 모델 행동 제어
- **RAG (Retrieval-Augmented Generation)**: 외부 지식 검색 + 생성 결합
- **In-Context Learning**: 예시를 프롬프트에 포함하여 학습 없이 태스크 수행

### 에이전트 아키텍처
- **ReAct**: Reasoning + Acting 패턴
- **Multi-Agent**: 여러 에이전트의 협업 오케스트레이션
- **Tool-Use Agent**: 외부 도구를 호출하는 에이전트
- **Agentic Workflow**: 자율적 판단과 실행 흐름

## 주요 이론/프레임워크
- Transformer Architecture (Vaswani et al., 2017)
- Scaling Laws for Neural Language Models
- Chain-of-Thought Reasoning (Wei et al., 2022)
- Constitutional AI / RLHF

## 비판적 관점
- 할루시네이션(Hallucination) 문제
- 재현성 이슈 (모델 버전, 온도 설정 등)
- 계산 비용 및 환경 영향
- 데이터 편향 전이

## 용어 사전
| 영어 | 한국어 | 설명 |
|------|--------|------|
| Hallucination | 환각 | 모델이 사실이 아닌 정보를 생성하는 현상 |
| Grounding | 근거 기반 | 외부 사실에 기반하여 응답을 생성하는 것 |
| Token | 토큰 | 모델이 처리하는 텍스트의 최소 단위 |
| Embedding | 임베딩 | 텍스트를 수치 벡터로 변환한 표현 |
