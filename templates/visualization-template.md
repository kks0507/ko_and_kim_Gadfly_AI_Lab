# 시각화 기획 출력 양식 (Visualization Planning Template)

이 양식은 `/gadfly-visualize` 커맨드의 출력 형식을 정의합니다.

---

## 출력 구조

### Section 1: 시각화 기획 요약 (Visualization Plan Summary)

```
[Visualization Plan Summary]:
  프로젝트: (프로젝트명)
  분석 유형: (기술통계/추론통계/고급통계/혼합)
  총 시각 자료 수: Table N개 + Figure N개
  APA 준수: Yes/No
```

### Section 2: 시각 자료 목록 (Visual Assets List)

```
[Visual Assets]:
  === Tables ===
  | # | Table 번호 | 제목 | 유형 | 해당 RQ | 근거 |
  |---|-----------|------|------|---------|------|
  | 1 | Table 1   | Descriptive Statistics... | 기술통계 표 | RQ1 | 주요 변인 요약 |
  | 2 | Table 2   | Multiple Regression... | 회귀분석 표 | RQ2 | 예측 관계 제시 |

  === Figures ===
  | # | Figure 번호 | 제목 | 유형 | 해당 RQ | 근거 |
  |---|------------|------|------|---------|------|
  | 1 | Figure 1   | Mean Scores by Group | 막대+오차 | RQ1 | 집단 간 비교 시각화 |
  | 2 | Figure 2   | Interaction Effect... | 상호작용 플롯 | RQ3 | 조절 효과 시각화 |
```

### Section 3: APA 표 (Markdown)

각 표는 APA 7th 형식으로 마크다운 출력:

```markdown
*Table 1*
*Descriptive Statistics and Correlations Among Study Variables*

| Variable     | M    | SD   | 1     | 2     | 3     |
|-------------|------|------|-------|-------|-------|
| 1. Variable A | 3.45 | 0.87 | —     |       |       |
| 2. Variable B | 4.12 | 0.65 | .34** | —     |       |
| 3. Variable C | 2.98 | 1.02 | .28*  | .45** | —     |

*Note.* N = 150. *p < .05. **p < .01.
```

### Section 4: Figure Python 코드

각 Figure에 대해 복사-붙여넣기 가능한 Matplotlib 코드 생성:

```
[Figure Code - Figure 1]:
  제목: (Figure 제목)
  유형: (막대 그래프 / 산점도 / 꺾은선 등)
  데이터: (사용 데이터 설명)

  --- Python Code ---
  (완전한 Matplotlib 코드)
  --- End Code ---

  실행 방법: python figure1.py
  출력 파일: figure1.png (300 DPI)
```

### Section 5: 본문 통합 가이드 (Text Integration Guide)

```
[Text Integration]:
  === Table 참조 문장 ===
  "Table 1에 주요 변인의 기술통계와 상관 분석 결과를 제시하였다."
  "Table 2에 제시된 바와 같이, X가 Y를 유의하게 예측하였다(β = .34, p < .001)."

  === Figure 참조 문장 ===
  "Figure 1에서 볼 수 있듯이, 실험 집단의 평균 점수가 통제 집단보다 유의하게 높았다."
  "Figure 2는 X와 Y의 관계에 대한 Z의 조절 효과를 보여준다."
```

### Section 6: 학술지 투고 체크리스트 (Submission Checklist)

```
[Submission Checklist]:
  □ 모든 표/그림이 본문에서 참조되었는가?
  □ 표/그림 번호가 본문 참조 순서와 일치하는가?
  □ APA 7th 형식이 준수되었는가? (제목 위치, 주석 등)
  □ Figure 해상도가 300 DPI 이상인가?
  □ 색각 이상 대응이 되었는가? (패턴/마커 병용)
  □ 흑백 인쇄 시에도 구분 가능한가?
  □ 표의 세로선이 없는가?
  □ Figure 파일 형식이 학술지 요구사항에 맞는가? (TIFF/EPS/PDF)
```

---

## 코드 생성 원칙

1. **완전성(Completeness)**: `import`부터 `plt.savefig()`까지 포함, 별도 설치 없이 실행 가능
2. **APA 스타일**: `set_apa_style()` 함수를 코드 상단에 포함
3. **데이터 분리**: 데이터 입력부를 코드 상단에 명확히 분리하여 연구자가 수정 용이
4. **접근성**: 색각 이상 대응 팔레트 사용, 마커/패턴 병용
5. **저장**: 300 DPI PNG 저장 + PDF 벡터 저장 모두 포함
6. **재현가능성**: 동일 코드 실행 시 동일 결과 보장

## CSV 칼럼 (gadfly-export 연동)

시각화 기획 결과를 CSV로 내보낼 때의 칼럼:
```
시각자료번호, 유형(Table/Figure), 제목, 해당RQ, 시각화유형, 데이터소스, 코드파일명, 상태
```
