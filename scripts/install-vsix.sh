#!/usr/bin/bash

#region Логирование
# Цвета ANSI
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
}

print_help() {
    cat << EOF
Usage: $(basename "$0") [options]
Install VSIX packages.

Args:
  -e, --exclude     Exclude vsix packages from installation.
  -h, --help
EOF
    exit 0
}
#endregion


while [[ $# -gt 0 ]]; do
    case "$1" in
        -e|--exclude)
            exclude="$2"
            shift 2
        ;;
        -h|--help)
            print_help
        ;;
        *)
            log_error "Неизвестный параметр: $1"
            print_help
        ;;
    esac
done

exclude_args=()
while IFS= read -r exc; do
    [ -z "$exc" ] && continue
    exclude_args+=(-not -name "$exc-pack.vsix")
done <<< "$(echo "$exclude" | tr ' ' '\n')"

in_files=$(find ./dist/packs -type f -name "*.vsix" "${exclude_args[@]}")

for i in $in_files; do 
    log_info "Install extension: $i"
    code --install-extension $i || {
        log_error "An error occurred when installing the extension : $i"
        continue
    }
    log_info "The extension is installed: $i";
done