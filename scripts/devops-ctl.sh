#!/usr/bin/env bash
# ==============================================================================
# DevOps Control & Automation Utility
# Author: Sanjar Oktamov
# ==============================================================================

set -euo pipefail

# Ranglar
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

usage() {
    echo "Foydalanish: $0 {build|up|down|restart|test|health|logs|status|clean}"
    echo
    echo "Buyruqlar:"
    echo "  build    - Docker obrazlarni yig'ish (build)"
    echo "  up       - Docker Compose konteynerlarini orqa fonda ishga tushirish"
    echo "  down     - Barcha konteynerlarni to'xtatish va o'chirish"
    echo "  restart  - Konteynerlarni qayta ishga tushirish"
    echo "  test     - Pytest orqali unit testlarni yurgizish"
    echo "  health   - Ilova sog'lomligini (/health) tekshirish"
    echo "  logs     - Konteyner loglarini kuzatish"
    echo "  status   - Konteynerlar va portlar holatini ko'rish"
    echo "  clean    - Foydalanilmayotgan Docker resurslarini tozalash"
    exit 1
}

cmd_build() {
    log_info "Docker obrazlar yig'ilmoqda..."
    docker compose -f "${ROOT_DIR}/docker-compose.yml" build
    log_success "Obrazlar muvaffaqiyatli yig'ildi."
}

cmd_up() {
    log_info "Servislar ishga tushirilmoqda..."
    docker compose -f "${ROOT_DIR}/docker-compose.yml" up -d
    log_success "Barcha servislar orqa fonda ishga tushdi."
}

cmd_down() {
    log_info "Servislar to'xtatilmoqda..."
    docker compose -f "${ROOT_DIR}/docker-compose.yml" down
    log_success "Konteynerlar to'xtatildi."
}

cmd_restart() {
    cmd_down
    cmd_up
}

cmd_test() {
    log_info "Pytest orqali unit testlar tekshirilmoqda..."
    if command -v pytest &>/dev/null; then
        PYTHONPATH="${ROOT_DIR}" pytest "${ROOT_DIR}/tests" -v
    else
        log_warn "Mahalliy 'pytest' topilmadi. Python test_app ishlatilmoqda..."
        python3 -m unittest discover -s "${ROOT_DIR}/tests" -v || true
    fi
    log_success "Testlar bajarildi."
}

cmd_health() {
    log_info "Endpoint tekshiruvi boshlandi..."
    local endpoint="http://localhost/health"
    if curl -s -f "$endpoint" > /dev/null; then
        echo -e "${GREEN}✓ HTTP 200 OK${NC}"
        curl -s "$endpoint" | grep -o '.*'
    else
        log_warn "80-portda Nginx orqali ulanib bo'lmadi. 5000-port to'g'ridan-to'g'ri sinab ko'riladi..."
        curl -s -f "http://localhost:5000/health" || log_error "Ilova ishlamayapti!"
    fi
}

cmd_logs() {
    docker compose -f "${ROOT_DIR}/docker-compose.yml" logs -f
}

cmd_status() {
    docker compose -f "${ROOT_DIR}/docker-compose.yml" ps
}

cmd_clean() {
    log_info "Foydalanilmayotgan Docker resurslari tozalanmoqda..."
    docker system prune -f
    log_success "Tozalash yakunlandi."
}

case "${1:-}" in
    build)   cmd_build ;;
    up)      cmd_up ;;
    down)    cmd_down ;;
    restart) cmd_restart ;;
    test)    cmd_test ;;
    health)  cmd_health ;;
    logs)    cmd_logs ;;
    status)  cmd_status ;;
    clean)   cmd_clean ;;
    *)       usage ;;
esac
