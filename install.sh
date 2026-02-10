#!/bin/bash
# Gadfly AI Lab - 설치 스크립트
# Claude Code의 agents/와 commands/에 심볼릭 링크를 생성합니다.

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "======================================"
echo "  Gadfly AI Lab - 설치"
echo "======================================"
echo ""

# 1. 사전 검증
if [ ! -d "$CLAUDE_DIR" ]; then
    echo "❌ 오류: $CLAUDE_DIR 디렉토리가 없습니다."
    echo "   Claude Code를 먼저 설치해주세요."
    exit 1
fi

echo "✓ Claude Code 설치 확인 완료"

# 2. 디렉토리 생성
mkdir -p "$CLAUDE_DIR/agents"
mkdir -p "$CLAUDE_DIR/commands"

# 3. 기존 gadfly- 파일 충돌 검사
EXISTING_AGENTS=$(ls "$CLAUDE_DIR/agents"/gadfly-*.md 2>/dev/null || true)
EXISTING_COMMANDS=$(ls "$CLAUDE_DIR/commands"/gadfly-*.md 2>/dev/null || true)

if [ -n "$EXISTING_AGENTS" ] || [ -n "$EXISTING_COMMANDS" ]; then
    echo ""
    echo "⚠️  기존 Gadfly 파일이 발견되었습니다. 덮어쓰시겠습니까? (y/N)"
    read -r response
    if [ "$response" != "y" ] && [ "$response" != "Y" ]; then
        echo "설치를 취소합니다."
        exit 0
    fi
fi

# 4. 에이전트 심볼릭 링크
echo ""
echo "📎 에이전트 등록 중..."
AGENT_COUNT=0
for agent_file in "$SCRIPT_DIR/agents"/gadfly-*.md; do
    if [ -f "$agent_file" ]; then
        filename=$(basename "$agent_file")
        ln -sf "$agent_file" "$CLAUDE_DIR/agents/$filename"
        echo "   → $filename"
        AGENT_COUNT=$((AGENT_COUNT + 1))
    fi
done
echo "   ✓ 에이전트 ${AGENT_COUNT}명 등록 완료"

# 5. 커맨드 심볼릭 링크
echo ""
echo "📎 커맨드 등록 중..."
COMMAND_COUNT=0
for cmd_file in "$SCRIPT_DIR/commands"/gadfly-*.md; do
    if [ -f "$cmd_file" ]; then
        filename=$(basename "$cmd_file")
        ln -sf "$cmd_file" "$CLAUDE_DIR/commands/$filename"
        echo "   → $filename"
        COMMAND_COUNT=$((COMMAND_COUNT + 1))
    fi
done
echo "   ✓ 커맨드 ${COMMAND_COUNT}개 등록 완료"

# 6. 작업 디렉토리 확인
echo ""
mkdir -p "$SCRIPT_DIR/output"
mkdir -p "$SCRIPT_DIR/projects"
echo "✓ 작업 디렉토리 확인 완료"

# 7. 팀 기능 확장 대비
if [ -d "$SCRIPT_DIR/team-configs" ] && [ "$(ls -A "$SCRIPT_DIR/team-configs" 2>/dev/null | grep -v .gitkeep)" ]; then
    echo ""
    echo "📎 팀 설정 등록 중..."
    # 향후 팀 기능 확장 시 여기에 로직 추가
    echo "   ✓ 팀 설정 등록 완료"
fi

# 8. 설치 기록
echo ""
cat > "$CLAUDE_DIR/.gadfly-lab-install" << EOF
install_path=$SCRIPT_DIR
install_date=$(date +%Y-%m-%d)
agents=$AGENT_COUNT
commands=$COMMAND_COUNT
EOF
echo "✓ 설치 기록 저장 완료"

# 9. 완료
echo ""
echo "======================================"
echo "  ✓ Gadfly AI Lab 설치 완료!"
echo "======================================"
echo ""
echo "  에이전트: ${AGENT_COUNT}명"
echo "  커맨드:   ${COMMAND_COUNT}개"
echo "  레포 경로: $SCRIPT_DIR"
echo ""
echo "  사용법:"
echo "    claude 실행 후:"
echo "    /gadfly-analyze <논문.pdf> --project <프로젝트명>"
echo "    /gadfly-batch <논문폴더> --project <프로젝트명>"
echo "    /gadfly-ideate <아이디어>"
echo "    /gadfly-new-project <프로젝트명>"
echo ""
