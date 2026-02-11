# 정밀 인용 출력 형식 (Precise Citation Output Format)

> Gadfly AI Lab의 모든 인용 추출은 이 형식을 따릅니다.
> Strict Verbatim 원칙: 인용구는 원문 그대로 추출, 한 글자의 오차도 불허.

## 단건 인용 형식

[Location]: P.{페이지}, Line {줄번호} (또는 Section {섹션}, Paragraph {단락번호})
[Original Text]: "원문 그대로"
[Context Before]: (인용구 직전 1-2문장)
[Context After]: (인용구 직후 1-2문장)
[Reason]: (한국어) 이 구절을 인용하는 이유
[Integration]: 패러프레이즈 추천 / 직접 인용 추천 (+ 근거)
[Connection]: 내 연구의 어떤 논점과 연결되는가

## CSV 칼럼 매핑

위 형식은 CSV 내보내기 시 다음 칼럼으로 변환됩니다:

| 인용 형식 필드 | CSV 칼럼 |
|---------------|---------|
| Location | 정밀 인용-Location |
| Original Text | 정밀 인용-Original Text |
| Context Before + After | 정밀 인용-맥락 |
| Reason | 정밀 인용-Reason |
| Integration | 정밀 인용-통합제안 |

## 복수 인용 시 형식

하나의 논문에서 여러 인용구를 추출할 경우:

### 인용 #1
[Location]: ...
[Original Text]: ...
(이하 동일)

### 인용 #2
[Location]: ...
[Original Text]: ...
(이하 동일)

## 주의사항

1. **Strict Verbatim**: 절대로 원문을 수정, 요약, 의역하지 않는다
2. **위치 정확성**: 페이지, 줄번호가 정확해야 한다. 불확실하면 "P.X (추정)" 표기
3. **맥락 제공**: 앞뒤 맥락이 있어야 인용의 의미가 전달된다
4. **통합 제안**: 패러프레이즈가 적절한지 직접 인용이 적절한지 판단 근거를 제시한다
