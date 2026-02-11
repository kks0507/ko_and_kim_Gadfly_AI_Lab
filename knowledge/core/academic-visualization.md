# 학술 시각화 (Academic Visualization)

## 핵심 개념

### 학술 시각화의 목적
- **데이터 시각화(Data Visualization)**: 통계 결과를 시각적으로 전달하여 독자의 이해를 돕는 것
- **방법론 다이어그램(Methodology Diagram)**: 연구 설계, 절차, 모형 구조를 시각적으로 설명
- **논문의 시각 자료는 본문의 반복이 아닌 보완**: 텍스트로 전달하기 어려운 패턴, 관계, 비교를 시각적으로 표현

### APA 7th 표(Table) 설계 원칙
- **번호와 제목**: 표 상단에 Table 번호(볼드) + 제목(이탤릭)
- **구조**: 세로선 금지(no vertical rules), 가로선 최소화(상단선, 열 구분선, 하단선만)
- **주석(Note)**: 표 하단에 일반 주석(Note.), 특수 주석(a, b), 확률 주석(*p < .05)
- **소수점**: 자릿수 통일, 단위 명시
- **자기완결성(Self-contained)**: 표만 보고 내용을 이해할 수 있어야 함

### APA 7th 그림(Figure) 설계 원칙
- **번호와 제목**: 그림 상단에 Figure 번호(볼드) + 제목(이탤릭) — APA 7th 변경사항
- **축 레이블**: 명확하고 단위 포함, 적절한 축 범위
- **범례(Legend)**: 그림 내부 또는 하단, 명확한 구분
- **오차 막대(Error bars)**: SD 또는 SE 명시, 95% CI 권장
- **해상도**: 최소 300 DPI (인쇄용), 벡터 형식(SVG/PDF) 우선
- **색상**: 흑백 인쇄 고려, 색각 이상(color blindness) 대응 — 패턴/마커 병용
- **글꼴**: 8-14pt sans-serif, 본문 글꼴과 일관성

## 통계 결과별 최적 시각화 유형

### 시각화 선택 매트릭스
| 분석 유형 | 추천 시각화 | APA 형식 | 대안 |
|-----------|------------|----------|------|
| 기술통계 (평균 비교) | 막대 그래프(Bar chart) + 오차 막대 | Figure | 표(Table) — 집단 3개 이하 |
| 집단 간 비교 (t-test, ANOVA) | 막대 그래프 + 오차 막대 | Figure | 바이올린 플롯(Violin plot) |
| 상관 관계 | 산점도(Scatter plot) + 회귀선 | Figure | 상관 행렬 히트맵(Heatmap) |
| 회귀 분석 결과 | 회귀 계수 테이블 | Table | 포레스트 플롯(Forest plot) |
| 구조방정식(SEM) | 경로도(Path diagram) | Figure | 적합도 지수 테이블 |
| 요인분석(EFA/CFA) | 요인 부하량 테이블 | Table | 스크리 도표(Scree plot) |
| 시계열/반복측정 | 꺾은선 그래프(Line chart) | Figure | 스파게티 플롯(개인별 변화) |
| 빈도/비율 | 막대 그래프, 원 그래프(제한적) | Figure | 빈도 테이블 |
| 효과크기 비교 | 포레스트 플롯(Forest plot) | Figure | 효과크기 테이블 |
| 군집/프로파일 | 프로파일 플롯(Profile plot) | Figure | 군집별 평균 테이블 |
| 매개/조절 효과 | 경로도 + 상호작용 플롯 | Figure | 계수 테이블 |
| 텍스트 분석 | 워드클라우드, 네트워크 그래프 | Figure | 빈도 테이블 |

### 표(Table) vs 그림(Figure) 선택 기준
| 기준 | 표 선택 | 그림 선택 |
|------|---------|----------|
| 정확한 수치가 중요 | O | X |
| 패턴/추세 파악이 중요 | X | O |
| 데이터 포인트 10개 이상 | O | O (산점도) |
| 집단 비교 3개 이하 | O | △ |
| 집단 비교 4개 이상 | △ | O |
| 상호작용 효과 | X | O (상호작용 플롯) |
| 모형 구조 | X | O (경로도) |

## Matplotlib 코드 생성 가이드

### APA 스타일 기본 설정
```python
import matplotlib.pyplot as plt
import matplotlib as mpl

# APA 7th 스타일 기본 설정
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
```

### 색각 이상 대응 팔레트
```python
# 색각 이상자 친화적 팔레트 (Wong, 2011)
COLORBLIND_SAFE = [
    '#0072B2',  # 파랑
    '#E69F00',  # 주황
    '#009E73',  # 초록
    '#CC79A7',  # 분홍
    '#56B4E9',  # 하늘
    '#D55E00',  # 빨강
    '#F0E442',  # 노랑
]

# 흑백 인쇄 대응: 마커 + 선 스타일 조합
MARKERS = ['o', 's', '^', 'D', 'v', 'P', 'X']
LINESTYLES = ['-', '--', '-.', ':', '-', '--', '-.']
HATCHES = ['///', '...', 'xxx', '\\\\\\', '|||', '+++', 'ooo']
```

### 주요 차트 유형별 코드 패턴

#### 1. 막대 그래프 + 오차 막대 (집단 비교)
```python
def bar_with_error(groups, means, sds, ylabel, title_num, title_text):
    """APA 형식 막대 그래프 + 오차 막대"""
    fig, ax = plt.subplots(figsize=(6, 4))
    bars = ax.bar(groups, means, yerr=sds, capsize=5,
                  color=COLORBLIND_SAFE[:len(groups)], edgecolor='black', linewidth=0.8)
    ax.set_ylabel(ylabel)
    ax.set_title(f'Figure {title_num}\n{title_text}', loc='left', fontstyle='italic')
    return fig
```

#### 2. 산점도 + 회귀선 (상관/회귀)
```python
def scatter_regression(x, y, xlabel, ylabel, title_num, title_text):
    """APA 형식 산점도 + 회귀선"""
    fig, ax = plt.subplots(figsize=(6, 5))
    ax.scatter(x, y, c=COLORBLIND_SAFE[0], alpha=0.7, edgecolors='black', linewidth=0.5)
    # 회귀선
    z = np.polyfit(x, y, 1)
    p = np.poly1d(z)
    ax.plot(sorted(x), p(sorted(x)), 'k--', linewidth=1.5)
    ax.set_xlabel(xlabel)
    ax.set_ylabel(ylabel)
    ax.set_title(f'Figure {title_num}\n{title_text}', loc='left', fontstyle='italic')
    return fig
```

#### 3. 상관 행렬 히트맵
```python
def correlation_heatmap(corr_matrix, labels, title_num, title_text):
    """APA 형식 상관 행렬 히트맵"""
    fig, ax = plt.subplots(figsize=(8, 6))
    im = ax.imshow(corr_matrix, cmap='RdBu_r', vmin=-1, vmax=1)
    # 수치 표기
    for i in range(len(labels)):
        for j in range(len(labels)):
            ax.text(j, i, f'{corr_matrix[i,j]:.2f}', ha='center', va='center', fontsize=9)
    ax.set_xticks(range(len(labels)))
    ax.set_yticks(range(len(labels)))
    ax.set_xticklabels(labels, rotation=45, ha='right')
    ax.set_yticklabels(labels)
    plt.colorbar(im, ax=ax, shrink=0.8)
    ax.set_title(f'Figure {title_num}\n{title_text}', loc='left', fontstyle='italic')
    return fig
```

#### 4. 상호작용 플롯 (조절 효과)
```python
def interaction_plot(x_levels, y_low, y_high, moderator_label, xlabel, ylabel, title_num, title_text):
    """APA 형식 상호작용 플롯"""
    fig, ax = plt.subplots(figsize=(6, 4))
    ax.plot(x_levels, y_low, 'o--', color=COLORBLIND_SAFE[0], label=f'{moderator_label} Low', linewidth=1.5)
    ax.plot(x_levels, y_high, 's-', color=COLORBLIND_SAFE[1], label=f'{moderator_label} High', linewidth=1.5)
    ax.set_xlabel(xlabel)
    ax.set_ylabel(ylabel)
    ax.legend()
    ax.set_title(f'Figure {title_num}\n{title_text}', loc='left', fontstyle='italic')
    return fig
```

#### 5. 포레스트 플롯 (효과크기 비교)
```python
def forest_plot(studies, effects, ci_lower, ci_upper, title_num, title_text):
    """APA 형식 포레스트 플롯"""
    fig, ax = plt.subplots(figsize=(8, len(studies)*0.5 + 2))
    y_pos = range(len(studies))
    ax.errorbar(effects, y_pos, xerr=[np.array(effects)-np.array(ci_lower),
                np.array(ci_upper)-np.array(effects)], fmt='ko', capsize=3, linewidth=1)
    ax.axvline(x=0, color='gray', linestyle='--', linewidth=0.8)
    ax.set_yticks(y_pos)
    ax.set_yticklabels(studies)
    ax.set_xlabel('Effect Size')
    ax.set_title(f'Figure {title_num}\n{title_text}', loc='left', fontstyle='italic')
    return fig
```

## APA 표 마크다운 변환 규칙

### 기술통계 표
```
Table 1
*Descriptive Statistics of Study Variables*

| Variable | M    | SD   | 1    | 2    | 3    |
|----------|------|------|------|------|------|
| 1. Var A | 3.45 | 0.87 | —    |      |      |
| 2. Var B | 4.12 | 0.65 | .34* | —    |      |
| 3. Var C | 2.98 | 1.02 | .28* | .45**| —    |

*Note.* N = 150. *p < .05. **p < .01.
```

### 회귀분석 표
```
Table 2
*Multiple Regression Analysis Predicting Y*

| Variable | B     | SE    | β     | t     | p     |
|----------|-------|-------|-------|-------|-------|
| (Constant) | 1.23 | 0.34 |      | 3.62  | .001  |
| Var A    | 0.45  | 0.12  | .34  | 3.75  | .001  |
| Var B    | 0.23  | 0.09  | .21  | 2.56  | .012  |

*Note.* R² = .28, F(2, 147) = 28.56, p < .001.
```

### ANOVA 결과 표
```
Table 3
*Analysis of Variance for DV by Group*

| Source    | SS      | df  | MS     | F     | p     | η²   |
|-----------|---------|-----|--------|-------|-------|------|
| Between   | 123.45  | 2   | 61.73  | 8.92  | .001  | .12  |
| Within    | 604.32  | 87  | 6.95   |       |       |      |
| Total     | 727.77  | 89  |        |       |       |      |

*Note.* N = 90 (n = 30 per group).
```

## 시각화 기획 절차 (PaperBanana 프레임워크 참조)

### 단계 1: 결과 분석 (Retrieval)
- 통계 분석 결과 유형 식별 (기술통계, 추론통계, 고급통계)
- 핵심 데이터 포인트 추출
- 연구 질문(RQ)별 결과 매핑

### 단계 2: 시각화 기획 (Planning)
- 각 결과에 최적 시각화 유형 선택 (시각화 선택 매트릭스 참조)
- 표(Table) vs 그림(Figure) 결정
- 레이아웃 및 배치 순서 계획
- 본문 참조 방식 계획 ("Table 1에 제시된 바와 같이...")

### 단계 3: 스타일 결정 (Styling)
- APA 7th 준수 여부 확인
- 색상 팔레트 선택 (색각 이상 대응)
- 글꼴, 크기, 해상도 설정
- 학술지별 요구사항 반영

### 단계 4: 코드 생성 (Visualization)
- 코드 기반 접근: Matplotlib/Python 코드 생성 (수치 정확도 보장)
- 복사-붙여넣기 가능한 완전한 코드 제공
- 데이터 입력부 + 시각화부 분리

### 단계 5: 검증 (Critique)
- APA 규격 준수 확인
- 데이터 정확성 확인
- 접근성(accessibility) 확인
- 학술지 투고 규정 부합 여부

## 학술지별 Figure 요구사항 (일반적)

| 항목 | 일반적 요구사항 |
|------|----------------|
| 해상도 | 300 DPI 이상 |
| 파일 형식 | TIFF, EPS, PDF (벡터 우선) |
| 색상 모드 | CMYK (인쇄) 또는 RGB (온라인) |
| 최대 크기 | 단칼럼(8.5cm) 또는 양칼럼(17.5cm) |
| 글꼴 | 8-12pt, sans-serif 권장 |
| 범례 | 그림 내부 또는 캡션에 포함 |

## 비판적 관점
- 과도한 시각화: 모든 결과를 시각화할 필요 없음, 핵심만 선별
- 3D 차트, 파이 차트는 학술 논문에서 비권장 (왜곡 가능성)
- 아름다움(aesthetics)보다 명확성(clarity)이 우선
- 시각화가 본문의 중복이 아닌 보완이 되어야 함
- AI 생성 시각화의 한계: 반드시 연구자가 수치 정확성 검증

## 용어 사전
| 영어 | 한국어 | 설명 |
|------|--------|------|
| Error Bar | 오차 막대 | 데이터의 변동성을 시각적으로 표현하는 막대 |
| Forest Plot | 포레스트 플롯 | 여러 연구/변인의 효과크기를 비교하는 도표 |
| Heatmap | 히트맵 | 색상 강도로 수치를 표현하는 행렬 시각화 |
| Path Diagram | 경로도 | SEM 모형의 변인 간 관계를 화살표로 표현 |
| Scree Plot | 스크리 도표 | 요인분석에서 고유값 감소를 보여주는 꺾은선 |
| Violin Plot | 바이올린 플롯 | 분포 형태와 요약 통계를 함께 보여주는 도표 |
| Color Blindness | 색각 이상 | 특정 색상을 구분하지 못하는 시각적 조건 |
| DPI | 인치당 점 | 이미지 해상도 단위 (Dots Per Inch) |
