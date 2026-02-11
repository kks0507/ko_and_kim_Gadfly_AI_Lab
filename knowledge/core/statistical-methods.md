# 통계 방법론 (Statistical Methods)

## 핵심 개념

### 기술통계 (Descriptive Statistics)
- **중심경향치**: 평균(Mean), 중앙값(Median), 최빈값(Mode)
- **산포도**: 표준편차(SD), 분산(Variance), 범위(Range), 사분위범위(IQR)
- **빈도분석(Frequency Analysis)**: 빈도, 백분율, 누적백분율
- **분포 특성**: 왜도(Skewness), 첨도(Kurtosis) — 정규성 판단 기초 지표
- APA 보고 예시: *M* = 3.45, *SD* = 0.87

### 추론통계 (Inferential Statistics)
- **t-test**: 두 집단 평균 비교 (독립표본/대응표본)
  - APA 보고: *t*(48) = 2.31, *p* = .025, *d* = 0.65
- **ANOVA**: 세 집단 이상 평균 비교 (일원/이원/반복측정)
  - 사후검정(Post-hoc): Tukey HSD, Bonferroni, Scheffé
  - APA 보고: *F*(2, 87) = 4.56, *p* = .013, η² = .10
- **카이제곱 검정(Chi-square)**: 범주형 변인 간 관련성 검정
  - APA 보고: χ²(3, *N* = 150) = 11.42, *p* = .010
- **회귀분석(Regression)**: 변인 간 예측 관계 분석
  - 단순/다중/위계적 회귀, 로지스틱 회귀
  - APA 보고: β = .34, *t* = 3.21, *p* = .002

### 고급통계 (Advanced Statistics)
- **구조방정식 모형(SEM)**: 잠재 변인 간 인과 경로 검증, 적합도 지수(CFI, TLI, RMSEA, SRMR)
- **위계적 선형 모형(HLM)**: 다수준 자료(학생-학급-학교) 분석, 집단 내 상관(ICC) 고려
- **요인분석(Factor Analysis)**: 탐색적(EFA) — 요인 구조 발견 / 확인적(CFA) — 요인 구조 검증
- **군집분석(Cluster Analysis)**: K-means, 계층적 군집, 잠재 프로파일 분석(LPA)
- **다변량 분석**: MANOVA, 정준상관분석, 판별분석

## 주요 프레임워크

### 효과크기 (Effect Size)
| 지표 | 사용 맥락 | 소 | 중 | 대 |
|------|-----------|-----|-----|-----|
| Cohen's *d* | 두 집단 평균 차이 | 0.2 | 0.5 | 0.8 |
| η² (Eta-squared) | ANOVA | .01 | .06 | .14 |
| *f*² | 회귀분석 | .02 | .15 | .35 |
| *r* | 상관 관계 | .10 | .30 | .50 |
| Cramér's *V* | 카이제곱 | .10 | .30 | .50 |

### 검정력 분석 (Power Analysis)
- **사전 검정력 분석(A priori)**: 연구 전 필요 표본 크기 산출
- **사후 검정력 분석(Post-hoc)**: 연구 후 실제 검정력 확인
- 권장 검정력: .80 이상 (Cohen, 1988)
- 핵심 요소: 효과크기, 유의수준(α), 검정력(1-β), 표본 크기
- 도구: G*Power, R `pwr` 패키지

### 가정 검증 (Assumption Testing)
| 가정 | 검증 방법 | 위반 시 대안 |
|------|-----------|-------------|
| 정규성(Normality) | Shapiro-Wilk, Q-Q plot, 왜도/첨도 | 비모수 검정(Mann-Whitney, Kruskal-Wallis) |
| 등분산성(Homogeneity) | Levene's test | Welch's t-test, Games-Howell 사후검정 |
| 다중공선성(Multicollinearity) | VIF(< 10), 공차(> .10) | 변인 제거, 주성분 회귀 |
| 독립성(Independence) | Durbin-Watson | 다수준 모형(HLM) 적용 |
| 선형성(Linearity) | 산점도, 잔차 도표 | 비선형 변환, 다항 회귀 |

## APA 7th 통계 보고 원칙
- 정확한 *p* 값 보고 (p < .001 제외), 이탤릭체로 통계 기호 표기
- 효과크기와 신뢰구간(CI) 반드시 포함
- 표본 크기(*N* 또는 *n*) 명시
- 소수점 이하 두 자리 보고 (상관계수, *p* 값은 세 자리)
- *p* 값 앞에 0 생략: *p* = .025 (O), *p* = 0.025 (X)

## 분석 도구
| 도구 | 특징 | 주요 용도 |
|------|------|-----------|
| SPSS | GUI 기반, 학습 용이 | 기본 통계, 한국 교육학 연구에서 널리 사용 |
| R | 오픈소스, 확장성 우수 | 고급 통계, SEM(`lavaan`), HLM(`lme4`), 시각화(`ggplot2`) |
| Python | 범용 프로그래밍, ML 연계 | `scipy`, `statsmodels`, `pingouin`, 자동화 분석 |
| jamovi | 오픈소스 GUI, R 기반 | SPSS 대안, 교육용 |
| G*Power | 검정력 분석 전용 | 표본 크기 산출 |

## 비판적 관점
- *p* 값 남용과 통계적 유의성의 과대 해석 (ASA Statement, 2016)
- 효과크기 없는 유의성만의 보고는 불충분
- 베이지안 통계(Bayesian Statistics)의 대안적 활용 가능성
- HARKing(Hypothesizing After Results are Known)과 p-hacking 문제
- 한국 교육 연구에서 SEM 남용에 대한 경고 (표본 크기, 모형 복잡성 고려 부족)

## 용어 사전
| 영어 | 한국어 | 설명 |
|------|--------|------|
| Effect Size | 효과크기 | 처치 효과의 실질적 크기를 나타내는 지표 |
| Power Analysis | 검정력 분석 | 통계적 검정이 효과를 탐지할 확률 분석 |
| Confidence Interval | 신뢰구간 | 모수가 포함될 것으로 추정되는 구간 |
| Structural Equation Modeling | 구조방정식 모형 | 잠재 변인 간 인과 관계를 검증하는 통계 모형 |
| Hierarchical Linear Modeling | 위계적 선형 모형 | 다수준(학생-학급) 자료를 분석하는 모형 |
| Latent Variable | 잠재 변인 | 직접 측정 불가능한 이론적 구성개념 |
| Multicollinearity | 다중공선성 | 독립 변인 간 높은 상관으로 인한 회귀 추정 왜곡 |
| Bayesian Statistics | 베이지안 통계 | 사전 확률을 갱신하여 사후 확률을 추정하는 접근 |
