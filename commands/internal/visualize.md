---
allowed-tools: Read, Glob, Grep, Task, Write, Bash
description: 분석 결과를 바탕으로 학술논문용 APA 표/그림을 기획하고 Matplotlib 코드를 생성한다.
---

# /gadfly-visualize

분석 결과(통계 데이터, /gadfly-results 출력물 등)를 바탕으로 학술논문에 삽입할 수 있는 APA 형식 표(Table)와 그림(Figure)을 기획하고, 바로 실행 가능한 Python/Matplotlib 코드를 생성합니다.

## 사용법

```
/gadfly-visualize --project <프로젝트명>
/gadfly-visualize <데이터 파일> --project <프로젝트명>
/gadfly-visualize <results 보고서> --project <프로젝트명>
```

## 실행 절차

### Phase 1: 소장 - 결과 데이터 수집 및 분석

1. 데이터 소스 확인:
   - `output/<프로젝트>/results-*.md` — 기존 /gadfly-results 출력물
   - 사용자가 직접 제공한 데이터 파일 (CSV, 통계 출력 등)
   - 사용자가 직접 입력한 통계 결과
2. `projects/<프로젝트명>.md`를 읽어 연구 맥락을 파악합니다:
   - 연구 질문(RQ) 목록
   - 방법론 유형 (양적/질적/혼합)
   - 주요 변인
3. `knowledge/core/academic-visualization.md`를 읽어 시각화 가이드를 참조합니다.
4. `templates/visualization-template.md`를 읽어 출력 양식을 확인합니다.

### Phase 2: 데이터 분석가 - 시각화 기획

**데이터 분석가(data-analyst)**에게 Task를 지시합니다:

- 결과 데이터 + 프로젝트 맥락 전달
- `knowledge/core/academic-visualization.md` 참조 지시 (시각화 선택 매트릭스)
- `knowledge/core/statistical-methods.md` 참조 지시
- 다음 사항을 기획하도록 요청:
  1. 각 RQ/결과별 최적 시각화 유형 선택 (표 vs 그림, 차트 유형)
  2. APA 형식 표(Table) 마크다운 작성
  3. APA 형식 그림(Figure)용 Matplotlib 코드 생성
  4. 본문 통합 참조 문장 제안
  5. 투고 체크리스트

필요 시 **기획전문가(planning)**도 추가 배치하여:
- 시각 자료 간 논리적 배치 순서 검토
- 전체 논문 구조에서의 시각 자료 역할 확인

### Phase 3: 소장 - 시각화 보고서 출력

```markdown
# 시각화 기획 보고서

## 프로젝트: [프로젝트명]

## 1. 시각화 기획 요약

| # | 유형 | 제목 | 시각화 방식 | 해당 RQ | 선택 근거 |
|---|------|------|-----------|---------|----------|

## 2. APA Tables

### Table 1
*[표 제목 — 이탤릭]*

| ... | ... | ... |
|-----|-----|-----|

*Note.* ...

### Table 2
...

## 3. APA Figures — Python 코드

### Figure 1: [제목]

**유형**: [막대 그래프 / 산점도 / 상호작용 플롯 등]
**해당 RQ**: [RQ 번호]

```python
# Figure 1: [제목]
# 실행: python figure1.py
# 출력: figure1.png (300 DPI), figure1.pdf (벡터)

import matplotlib.pyplot as plt
import matplotlib as mpl
import numpy as np

# === APA 스타일 설정 ===
def set_apa_style():
    mpl.rcParams.update({
        'font.family': 'sans-serif',
        'font.sans-serif': ['Arial', 'Helvetica'],
        'font.size': 11,
        'axes.linewidth': 1.0,
        'axes.spines.top': False,
        'axes.spines.right': False,
        'figure.dpi': 300,
        'savefig.dpi': 300,
        'savefig.bbox': 'tight',
        'legend.frameon': False,
    })

set_apa_style()

# === 색각 이상 대응 팔레트 ===
COLORS = ['#0072B2', '#E69F00', '#009E73', '#CC79A7', '#56B4E9', '#D55E00']

# === 데이터 (연구자가 수정) ===
# [여기에 실제 데이터 입력]

# === 시각화 ===
fig, ax = plt.subplots(figsize=(6, 4))

# [차트 코드]

# === 제목 및 레이블 (APA 7th) ===
ax.set_title('Figure 1\n[제목]', loc='left', fontstyle='italic', fontsize=11)
ax.set_xlabel('[X축 레이블]')
ax.set_ylabel('[Y축 레이블]')

plt.tight_layout()
plt.savefig('figure1.png', dpi=300, bbox_inches='tight')
plt.savefig('figure1.pdf', bbox_inches='tight')
plt.show()
```

### Figure 2: [제목]
...

## 4. 본문 통합 가이드

### Table 참조 문장
- "Table 1에 주요 변인의 기술통계와 상관 분석 결과를 제시하였다."
- ...

### Figure 참조 문장
- "Figure 1에서 볼 수 있듯이, ..."
- ...

## 5. 투고 체크리스트

- [ ] 모든 표/그림이 본문에서 참조되었는가?
- [ ] 표/그림 번호가 본문 참조 순서와 일치하는가?
- [ ] APA 7th 형식 준수 (제목 위치, 주석, 이탤릭)
- [ ] Figure 해상도 300 DPI 이상
- [ ] 색각 이상 대응 (패턴/마커 병용)
- [ ] 흑백 인쇄 시 구분 가능
- [ ] 표에 세로선 없음
- [ ] 소수점 자릿수 통일
```

보고서를 `output/<프로젝트>/visualize-YYYY-MM-DD.md`로 저장합니다.
Figure 코드 파일을 `output/<프로젝트>/figures/figure1.py`, `figure2.py` 등으로 개별 저장합니다.
