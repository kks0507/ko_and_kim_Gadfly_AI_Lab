#!/bin/bash
# Gadfly AI Lab - 제거 스크립트
# 심볼릭 링크만 제거합니다. 연구 데이터(projects/, output/)는 보존됩니다.

set -e

CLAUDE_DIR="$HOME/.claude"

echo "======================================"
echo "  Gadfly AI Lab - 제거"
echo "======================================"
echo ""

# 1. 설치 기록 확인
if [ ! -f "$CLAUDE_DIR/.gadfly-lab-install" ]; then
    echo "⚠️  Gadfly AI Lab 설치 기록이 없습니다."
    echo "   수동으로 제거하시겠습니까? (y/N)"
    read -r response
    if [ "$response" != "y" ] && [ "$response" != "Y" ]; then
        echo "제거를 취소합니다."
        exit 0
    fi
fi

# 2. 에이전트 심볼릭 링크 제거
echo "🗑  에이전트 제거 중..."
REMOVED_AGENTS=0
for agent_file in "$CLAUDE_DIR/agents"/gadfly-*.md; do
    if [ -L "$agent_file" ]; then
        rm "$agent_file"
        echo "   → $(basename "$agent_file") 제거"
        REMOVED_AGENTS=$((REMOVED_AGENTS + 1))
    fi
done
echo "   ✓ 에이전트 ${REMOVED_AGENTS}명 제거 완료"

# 3. 커맨드 심볼릭 링크 제거
echo ""
echo "🗑  커맨드 제거 중..."
REMOVED_COMMANDS=0
for cmd_file in "$CLAUDE_DIR/commands"/gadfly-*.md; do
    if [ -L "$cmd_file" ]; then
        rm "$cmd_file"
        echo "   → $(basename "$cmd_file") 제거"
        REMOVED_COMMANDS=$((REMOVED_COMMANDS + 1))
    fi
done
echo "   ✓ 커맨드 ${REMOVED_COMMANDS}개 제거 완료"

# 4. 설치 기록 제거
if [ -f "$CLAUDE_DIR/.gadfly-lab-install" ]; then
    rm "$CLAUDE_DIR/.gadfly-lab-install"
fi

# 5. 완료
echo ""
echo "======================================"
echo "  ✓ Gadfly AI Lab 제거 완료!"
echo "======================================"
echo ""
echo "  ⚠️  다음은 보존되었습니다:"
echo "     - projects/ (프로젝트 설정 파일)"
echo "     - output/   (분석 결과물)"
echo "     - knowledge/ (도메인 지식)"
echo ""
echo "  완전 삭제를 원하시면 레포 디렉토리를 직접 삭제해주세요."
echo ""
