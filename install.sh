#!/bin/bash
# Gadfly AI Lab v2.1 - 설치 스크립트
# Claude Code의 agents/, commands/에 심볼릭 링크를 생성하고
# tensw-claude 통합 및 Agent Teams 설정을 자동 병합합니다.

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
BACKUP_SUFFIX="backup.$(date +%Y%m%d)"

# 색상
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

info()  { echo -e "${BLUE}[INFO]${NC} $1"; }
ok()    { echo -e "${GREEN}[OK]${NC} $1"; }
warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }
err()   { echo -e "${RED}[ERROR]${NC} $1"; }

# 카운터
AGENT_COUNT=0
COMMAND_COUNT=0
TENSW_CMD_COUNT=0
SETTINGS_MERGED=false
DASHBOARD_OK=false

echo ""
echo "======================================"
echo "  Gadfly AI Lab v2.1 - 설치"
echo "======================================"
echo ""

# ─────────────────────────────────────
# 1. 사전 검증
# ─────────────────────────────────────

# Claude Code 확인
if [ ! -d "$CLAUDE_DIR" ]; then
    err "$CLAUDE_DIR 디렉토리가 없습니다. Claude Code를 먼저 설치해주세요."
    exit 1
fi
ok "Claude Code 설치 확인"

# jq 확인
JQ_AVAILABLE=false
if command -v jq &>/dev/null; then
    JQ_AVAILABLE=true
    ok "jq 설치 확인"
else
    warn "jq가 설치되어 있지 않습니다. settings.json 자동 병합을 건너뜁니다."
    warn "  macOS: brew install jq"
    warn "  Linux: sudo apt-get install jq"
fi

# node/npm 확인
NODE_AVAILABLE=false
if command -v node &>/dev/null && command -v npm &>/dev/null; then
    NODE_AVAILABLE=true
    ok "Node.js/npm 설치 확인"
else
    warn "Node.js/npm이 설치되어 있지 않습니다. 대시보드 설치를 건너뜁니다."
fi

# tmux 확인
if command -v tmux &>/dev/null; then
    ok "tmux 설치 확인 (실시간 팀 모드 사용 가능)"
else
    warn "tmux가 설치되어 있지 않습니다. 실시간 팀 모드 사용 시 필요합니다."
    warn "  macOS: brew install tmux"
fi

# ─────────────────────────────────────
# 2. tensw 서브모듈 초기화
# ─────────────────────────────────────

info "tensw-claude 서브모듈 초기화 중..."
if [ -f "$SCRIPT_DIR/.gitmodules" ]; then
    (cd "$SCRIPT_DIR" && git submodule init 2>/dev/null && git submodule update 2>/dev/null) && \
        ok "tensw-claude 서브모듈 초기화 완료" || \
        warn "tensw-claude 서브모듈 초기화 실패 (git 환경을 확인해주세요)"
else
    warn ".gitmodules가 없습니다. tensw-claude 서브모듈 건너뜀"
fi

# ─────────────────────────────────────
# 3. 디렉토리 생성
# ─────────────────────────────────────

mkdir -p "$CLAUDE_DIR/agents"
mkdir -p "$CLAUDE_DIR/commands"

# ─────────────────────────────────────
# 4. 기존 gadfly- 파일 충돌 검사
# ─────────────────────────────────────

EXISTING_AGENTS=$(ls "$CLAUDE_DIR/agents"/gadfly-*.md 2>/dev/null || true)
EXISTING_COMMANDS=$(ls "$CLAUDE_DIR/commands"/gadfly-*.md 2>/dev/null || true)

if [ -n "$EXISTING_AGENTS" ] || [ -n "$EXISTING_COMMANDS" ]; then
    echo ""
    warn "기존 Gadfly 파일이 발견되었습니다. 덮어쓰시겠습니까? (y/N)"
    read -r response
    if [ "$response" != "y" ] && [ "$response" != "Y" ]; then
        echo "설치를 취소합니다."
        exit 0
    fi
fi

# ─────────────────────────────────────
# 5. Gadfly 에이전트 심볼릭 링크 (8개)
# ─────────────────────────────────────

echo ""
info "Gadfly 에이전트 등록 중..."
for agent_file in "$SCRIPT_DIR/agents"/gadfly-*.md; do
    if [ -f "$agent_file" ]; then
        filename=$(basename "$agent_file")
        ln -sf "$agent_file" "$CLAUDE_DIR/agents/$filename"
        ok "  $filename"
        AGENT_COUNT=$((AGENT_COUNT + 1))
    fi
done
ok "에이전트 ${AGENT_COUNT}명 등록 완료"

# ─────────────────────────────────────
# 6. Gadfly 커맨드 심볼릭 링크 (6개 상위 커맨드만)
# ─────────────────────────────────────

echo ""
info "Gadfly 커맨드 등록 중..."
for cmd_file in gadfly.md gadfly-plan.md gadfly-litreview.md gadfly-method.md gadfly-result.md gadfly-conclusion.md; do
    if [ -f "$SCRIPT_DIR/commands/$cmd_file" ]; then
        ln -sf "$SCRIPT_DIR/commands/$cmd_file" "$CLAUDE_DIR/commands/$cmd_file"
        ok "  $cmd_file"
        COMMAND_COUNT=$((COMMAND_COUNT + 1))
    fi
done
ok "커맨드 ${COMMAND_COUNT}개 등록 완료"

# ─────────────────────────────────────
# 7. tensw 커맨드 심볼릭 링크
# ─────────────────────────────────────

echo ""
info "tensw 커맨드 등록 중..."

TENSW_DIR="$SCRIPT_DIR/tensw-claude"

if [ -d "$TENSW_DIR/commands" ]; then
    # tensw-team, tensw-company 커맨드
    for cmd_file in "$TENSW_DIR/commands"/*.md; do
        if [ -f "$cmd_file" ]; then
            filename=$(basename "$cmd_file")
            ln -sf "$cmd_file" "$CLAUDE_DIR/commands/$filename"
            ok "  $filename"
            TENSW_CMD_COUNT=$((TENSW_CMD_COUNT + 1))
        fi
    done

    # company-build-data 디렉토리 (프리셋 등)
    if [ -d "$TENSW_DIR/commands/company-build-data" ]; then
        mkdir -p "$CLAUDE_DIR/commands/company-build-data"
        for data_file in "$TENSW_DIR/commands/company-build-data"/*; do
            if [ -f "$data_file" ]; then
                filename=$(basename "$data_file")
                ln -sf "$data_file" "$CLAUDE_DIR/commands/company-build-data/$filename"
                ok "  company-build-data/$filename"
            fi
        done
    fi

    ok "tensw 커맨드 ${TENSW_CMD_COUNT}개 등록 완료"
else
    warn "tensw-claude/commands 디렉토리가 없습니다. tensw 커맨드 건너뜀"
fi

# ─────────────────────────────────────
# 8. 프리셋 등록
# ─────────────────────────────────────

echo ""
info "연구소 프리셋 등록 중..."

PRESET_FILE="$SCRIPT_DIR/team-configs/research-lab-preset.json"
if [ -f "$PRESET_FILE" ]; then
    # tensw의 presets.json이 있으면 병합, 없으면 직접 복사
    TENSW_PRESETS="$CLAUDE_DIR/commands/company-build-data/presets.json"
    if [ -f "$TENSW_PRESETS" ] && [ "$JQ_AVAILABLE" = true ]; then
        # 기존 presets.json에 research-lab 프리셋 병합
        MERGED=$(jq -s '
            .[0].companies as $existing |
            .[1].companies as $new |
            .[0] | .companies = ($existing + ($new | map(select(.id as $id | $existing | map(.id) | index($id) | not))))
        ' "$TENSW_PRESETS" "$PRESET_FILE")
        echo "$MERGED" | jq '.' > "$TENSW_PRESETS"
        ok "research-lab 프리셋이 tensw presets.json에 병합됨"
    else
        # 프리셋 파일을 직접 company-build-data에 복사
        mkdir -p "$CLAUDE_DIR/commands/company-build-data"
        cp "$PRESET_FILE" "$CLAUDE_DIR/commands/company-build-data/research-lab-preset.json"
        ok "research-lab 프리셋 독립 등록"
    fi
else
    warn "team-configs/research-lab-preset.json이 없습니다. 프리셋 건너뜀"
fi

# ─────────────────────────────────────
# 9. Agent Teams 설정 자동 병합
# ─────────────────────────────────────

echo ""
info "Agent Teams 설정 병합 중..."

USER_SETTINGS="$CLAUDE_DIR/settings.json"

if [ "$JQ_AVAILABLE" = true ]; then
    # 백업 생성
    if [ -f "$USER_SETTINGS" ]; then
        cp "$USER_SETTINGS" "$USER_SETTINGS.$BACKUP_SUFFIX"
        ok "settings.json 백업 생성: settings.json.$BACKUP_SUFFIX"
    fi

    # 병합할 설정
    TEAM_SETTINGS='{"env":{"CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS":"1"},"teammateMode":"tmux"}'

    if [ -f "$USER_SETTINGS" ]; then
        # deep merge: 기존 설정 보존하면서 팀 설정 추가
        MERGED=$(echo "$TEAM_SETTINGS" | jq -s '.[1] * .[0]' "$USER_SETTINGS" -)
        echo "$MERGED" | jq '.' > "$USER_SETTINGS"
    else
        echo "$TEAM_SETTINGS" | jq '.' > "$USER_SETTINGS"
    fi

    # 검증
    VERIFY=$(jq -r '.env.CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS' "$USER_SETTINGS" 2>/dev/null)
    if [ "$VERIFY" = "1" ]; then
        ok "settings.json 병합 완료 (AGENT_TEAMS=1 확인)"
        SETTINGS_MERGED=true
    else
        err "settings.json 병합 검증 실패. 수동으로 설정해주세요."
    fi
else
    warn "jq 미설치로 settings.json 자동 병합 불가"
    echo ""
    warn "수동으로 ~/.claude/settings.json에 다음을 추가해주세요:"
    echo '  {'
    echo '    "env": {'
    echo '      "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS": "1"'
    echo '    },'
    echo '    "teammateMode": "tmux"'
    echo '  }'
fi

# ─────────────────────────────────────
# 10. 대시보드 npm install
# ─────────────────────────────────────

echo ""
info "대시보드 설치 중..."

if [ "$NODE_AVAILABLE" = true ] && [ -d "$TENSW_DIR/apps" ]; then
    for dashboard_dir in "$TENSW_DIR/apps"/tensw-*-dashboard; do
        if [ -d "$dashboard_dir" ]; then
            dashboard_name=$(basename "$dashboard_dir")
            if [ ! -d "$dashboard_dir/node_modules" ]; then
                info "  $dashboard_name: npm install 실행 중..."
                (cd "$dashboard_dir" && npm install --silent 2>&1) && \
                    ok "  $dashboard_name: 설치 완료" || \
                    warn "  $dashboard_name: npm install 실패 (나중에 수동 실행)"
            else
                ok "  $dashboard_name: 이미 설치됨"
            fi
            DASHBOARD_OK=true
        fi
    done
else
    if [ "$NODE_AVAILABLE" = false ]; then
        warn "Node.js 미설치로 대시보드 건너뜀"
    else
        warn "tensw-claude/apps 디렉토리가 없습니다"
    fi
fi

# ─────────────────────────────────────
# 11. 작업 디렉토리 생성
# ─────────────────────────────────────

mkdir -p "$SCRIPT_DIR/output"
mkdir -p "$SCRIPT_DIR/projects"

# ─────────────────────────────────────
# 12. 설치 기록 및 완료 보고
# ─────────────────────────────────────

cat > "$CLAUDE_DIR/.gadfly-lab-install" << EOF
install_path=$SCRIPT_DIR
install_date=$(date +%Y-%m-%d)
version=2.1
agents=$AGENT_COUNT
commands=$COMMAND_COUNT
tensw_commands=$TENSW_CMD_COUNT
settings_merged=$SETTINGS_MERGED
dashboard=$DASHBOARD_OK
backup_suffix=$BACKUP_SUFFIX
EOF

echo ""
echo "======================================"
echo -e "  ${GREEN}Gadfly AI Lab v2.1 설치 완료!${NC}"
echo "======================================"
echo ""
echo -e "  에이전트:       ${GREEN}${AGENT_COUNT}명${NC} (Director + 7 전문가)"
echo -e "  Gadfly 커맨드:  ${GREEN}${COMMAND_COUNT}개${NC} (5단계 + 스마트 라우터)"
echo -e "  tensw 커맨드:   ${GREEN}${TENSW_CMD_COUNT}개${NC}"
if [ "$SETTINGS_MERGED" = true ]; then
    echo -e "  Settings:       ${GREEN}병합 완료${NC} (백업: settings.json.$BACKUP_SUFFIX)"
else
    echo -e "  Settings:       ${YELLOW}수동 설정 필요${NC}"
fi
if [ "$DASHBOARD_OK" = true ]; then
    echo -e "  대시보드:       ${GREEN}설치됨${NC}"
else
    echo -e "  대시보드:       ${YELLOW}건너뜀${NC}"
fi
echo ""
echo "  레포 경로: $SCRIPT_DIR"
echo ""
echo "  사용법 (Claude Code 실행 후):"
echo "    /gadfly <자연어 요청>                        스마트 라우터 (자동 판단)"
echo "    /gadfly-plan <아이디어>                       연구 기획 (프로젝트+아이디어+검색전략+시스템설계)"
echo "    /gadfly-litreview <논문.pdf> --project <이름>  문헌 고찰 (인용/분석/일괄/리뷰/내보내기)"
echo "    /gadfly-method --project <이름>               방법론 설계 (추천+실험+IRB+설문+시스템구현)"
echo "    /gadfly-result <데이터> --project <이름>       결과 분석 (통계+시각화 자동 연계)"
echo "    /gadfly-conclusion --project <이름>            결론 (고찰+한계+기여+출판전략)"
echo "    /tensw-company research-lab                   연구소 팀 모드"
echo ""
echo -e "  ${YELLOW}중요: Claude Code를 재시작해주세요.${NC}"
echo ""
