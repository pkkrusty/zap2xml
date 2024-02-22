#!/bin/bash
set -eo pipefail
echo "Begin - ${0##*/}"

# lint CI code
printf '\e[1;35m===== Lint zap2xml.pl Whitespace =====\e[0m\n'
ee bashate -i E006,E010,E040 zap2xml.pl
printf '\e[37m===== Lint CI =====\e[0m\n'
ee bashate -i E006 .github/workflows/deps.sh
ee shellcheck -x -f gcc .github/workflows/deps.sh
ee bashate -i E006 .github/workflows/docker.sh
ee shellcheck -e SC2016 -x -f gcc .github/workflows/docker.sh
ee bashate -i E006 .github/workflows/lint.sh
ee shellcheck -x -f gcc .github/workflows/lint.sh

echo "Done. - ${0##*/}"
