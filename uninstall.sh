#!/bin/bash
# Gadfly AI Lab v2.1 - 제거 스크립트
# 심볼릭 링크와 tensw 통합을 제거합니다.
# 연구 데이터(projects/, output/, knowledge/)는 보존됩니다.

set -e

CLAUDE_DIR="$HOME/.claude"
INSTALL_RECORD="$CLAUDE_DIR/.gadfly-lab-install"

# 색상
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

info()  { echo -e "${BLUE}[INFO]${NC} $1"; }
ok()    { echo -e "${GREEN}[OK]${NC} $1"; }
warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }

# 카운터
REMOVED_AGENTS=0
REMOVED_COMMANDS=0
REMOVED_TENSW=0

echo ""
echo "======================================"
echo "  Gadfly AI Lab v2.1 - 제거"
echo "======================================"
echo ""

# ─────────────────────────────────────
# 1. 설치 기록 확인
# ─────────────────────────────────────

BACKUP_SUFFIX=""
if [ -f "$INSTALL_RECORD" ]; then
    BACKUP_SUFFIX=$(grep "backup_suffix=" "$INSTALL_RECORD" 2>/dev/null | cut -d= -f2)
    ok "설치 기록 확인됨"
else
    warn "Gadfly AI Lab 설치 기록이 없습니다."
    echo "  수동으로 제거하시겠습니까? (y/N)"
    read -r response
    if [ "$response" != "y" ] && [ "$response" != "Y" ]; then
        echo "제거를 취소합니다."
        exit 0
    fi
fi

# ─────────────────────────────────────
# 2. Gadfly 에이전트 심볼릭 링크 제거 (8개)
# ─────────────────────────────────────

info "Gadfly 에이전트 제거 중..."
for agent_file in "$CLAUDE_DIR/agents"/gadfly-*.md; do
    if [ -L "$agent_file" ]; then
        rm "$agent_file"
        ok "  $(basename "$agent_file") 제거"
        REMOVED_AGENTS=$((REMOVED_AGENTS + 1))
    fi
done
ok "에이전트 ${REMOVED_AGENTS}명 제거 완료"

# ─────────────────────────────────────
# 3. Gadfly 커맨드 심볼릭 링크 제거 (6개 상위 커맨드)
# ─────────────────────────────────────

echo ""
info "Gadfly 커맨드 제거 중..."
for cmd_file in "$CLAUDE_DIR/commands"/gadfly*.md; do
    if [ -L "$cmd_file" ]; then
        rm "$cmd_file"
        ok "  $(basename "$cmd_file") 제거"
        REMOVED_COMMANDS=$((REMOVED_COMMANDS + 1))
    fi
done
ok "커맨드 ${REMOVED_COMMANDS}개 제거 완료"

# ─────────────────────────────────────
# 4. tensw 커맨드 심볼릭 링크 제거
# ─────────────────────────────────────

echo ""
info "tensw 커맨드 제거 중..."
for cmd_file in "$CLAUDE_DIR/commands"/tensw-*.md; do
    if [ -L "$cmd_file" ]; then
        rm "$cmd_file"
        ok "  $(basename "$cmd_file") 제거"
        REMOVED_TENSW=$((REMOVED_TENSW + 1))
    fi
done

# company-build-data 심링크 제거
if [ -d "$CLAUDE_DIR/commands/company-build-data" ]; then
    for data_file in "$CLAUDE_DIR/commands/company-build-data"/*; do
        if [ -L "$data_file" ]; then
            rm "$data_file"
            ok "  company-build-data/$(basename "$data_file") 제거"
        fi
    done
    # 디렉토리가 비어있으면 제거
    rmdir "$CLAUDE_DIR/commands/company-build-data" 2>/dev/null || true
fi
ok "tensw 커맨드 ${REMOVED_TENSW}개 제거 완료"

# ─────────────────────────────────────
# 5. settings.json 복원
# ─────────────────────────────────────

echo ""
info "settings.json 복원 중..."

if [ -n "$BACKUP_SUFFIX" ] && [ -f "$CLAUDE_DIR/settings.json.$BACKUP_SUFFIX" ]; then
    cp "$CLAUDE_DIR/settings.json.$BACKUP_SUFFIX" "$CLAUDE_DIR/settings.json"
    ok "settings.json 복원 완료 (백업: settings.json.$BACKUP_SUFFIX)"
elif command -v jq &>/dev/null && [ -f "$CLAUDE_DIR/settings.json" ]; then
    # jq로 Agent Teams 설정만 제거
    jq 'del(.env.CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS) | del(.teammateMode) | if .env == {} then del(.env) else . end' \
        "$CLAUDE_DIR/settings.json" > "$CLAUDE_DIR/settings.json.tmp" && \
        mv "$CLAUDE_DIR/settings.json.tmp" "$CLAUDE_DIR/settings.json"
    ok "settings.json에서 Agent Teams 설정 제거"
else
    warn "settings.json 복원 건너뜀 (백업 파일 없음)"
    warn "필요 시 수동으로 CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS와 teammateMode를 제거해주세요."
fi

# ─────────────────────────────────────
# 6. 설치 기록 제거
# ─────────────────────────────────────

if [ -f "$INSTALL_RECORD" ]; then
    rm "$INSTALL_RECORD"
fi

# ─────────────────────────────────────
# 7. 완료
# ─────────────────────────────────────

echo ""
echo "======================================"
echo -e "  ${GREEN}Gadfly AI Lab v2.1 제거 완료!${NC}"
echo "======================================"
echo ""
echo -e "  에이전트: ${GREEN}${REMOVED_AGENTS}명${NC} 제거"
echo -e "  Gadfly 커맨드: ${GREEN}${REMOVED_COMMANDS}개${NC} 제거"
echo -e "  tensw 커맨드: ${GREEN}${REMOVED_TENSW}개${NC} 제거"
echo ""
echo -e "  ${YELLOW}다음은 보존되었습니다:${NC}"
echo "     - projects/ (프로젝트 설정 파일)"
echo "     - output/   (분석 결과물)"
echo "     - knowledge/ (도메인 지식)"
echo ""
echo "  완전 삭제를 원하시면 레포 디렉토리를 직접 삭제해주세요."
echo -e "  ${YELLOW}중요: Claude Code를 재시작해주세요.${NC}"
echo ""
