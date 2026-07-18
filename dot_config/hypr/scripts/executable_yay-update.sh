#!/usr/bin/env bash
# yay-update.sh — Run yay -Syu, clean failed PKGBUILD caches, retry once.

set -uo pipefail

YAY_CACHE="${HOME}/.cache/yay"
MAX_RETRIES=2

LOGFILE=$(mktemp /tmp/yay-update.XXXXXX)
trap 'rm -f "$LOGFILE"' EXIT

clean_failed_pkgs() {
    local -a failed=()

    while IFS= read -r pkg; do
        failed+=("$pkg")
    done < <(grep "Failed to download PKGBUILD: " "$LOGFILE" | cut -d' ' -f7)

    if [[ ${#failed[@]} -eq 0 ]]; then
        return 1  # No failed packages found
    fi

    echo "==> Found ${#failed[@]} failed PKGBUILD(s): ${failed[*]}"

    for pkg in "${failed[@]}"; do
        local cache_path="${YAY_CACHE}/${pkg}/"
        echo "  -> Trashing: ${cache_path}"
        rm -rf "$cache_path"
    done

    return 0
}

main() {
    local attempt=0

    while (( attempt < MAX_RETRIES )); do
        (( attempt++ )) || true
        echo ""
        echo "==> [Attempt ${attempt}/${MAX_RETRIES}] Running: yay -Syu --noconfirm --needed"
        echo ""

        : > "$LOGFILE"
        yay -Syu --noconfirm --needed 2>&1 | tee "$LOGFILE"
        yay_exit="${PIPESTATUS[0]}"

        if [[ "$yay_exit" -eq 0 ]]; then
            echo ""
            echo "==> Update completed successfully."
            exit 0
        fi

        echo ""
        echo "==> yay exited with code ${yay_exit}. Checking for failed PKGBUILDs..."

        if ! clean_failed_pkgs; then
            echo "==> No failed PKGBUILDs detected — unrelated error. Aborting."
            exit "${yay_exit}"
        fi

        if (( attempt >= MAX_RETRIES )); then
            echo "==> Max retries reached. Some packages may still be failing."
            exit "${yay_exit}"
        fi

        echo ""
        echo "==> Retrying after cleaning failed caches..."
    done
}

main "$@"
