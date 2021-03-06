#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2016-09-23 09:16:45 +0200 (Fri, 23 Sep 2016)
#
#  https://github.com/harisekhon/Dockerfiles
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x
srcdir="$(cd "$(dirname "$0")" && pwd)"

echo "Dockerfiles PyTools Checks"

cd "$srcdir/.."

export PATH=$PATH:$PWD/pytools_checks

get_pytools(){
    if ! [ -d pytools_checks ]; then
        git clone https://github.com/harisekhon/pytools pytools_checks
        cd pytools_checks
        make
    fi
}

if ! which dockerfiles_check_git_branches.py &>/dev/null ||
   ! which git_check_branches_upstream.py &>/dev/null
    then
    get_pytools
fi

dockerfiles_check_git_branches.py .

git_check_branches_upstream.py .
