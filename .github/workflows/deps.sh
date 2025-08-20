#!/bin/bash
set -eo pipefail
echo "Begin - ${0##*/}"

# ee
sudo curl -fsSL 'https://raw.githubusercontent.com/pkkrusty/echo-eval/main/ee.sh' -o /usr/local/bin/ee
sudo chmod +x /usr/local/bin/ee

# apt
ee sudo apt-get update -qq
ee sudo apt-get install -yqq \
    python3-bashate \
    shellcheck \
        '>/dev/null'

# versions
source /etc/os-release || :
echo "$NAME $VERSION" || :
ee uname -r || :
ee 'bash --version | head -1' || :
ee "apt-cache show python3-bashate | grep -i version | cut -d ' ' -f 2" || :
ee docker --version || :
ee shellcheck --version || :

echo "Done. - ${0##*/}"
