#!/bin/bash
# This script is meant to be called by the "install" step defined in
# .travis.yml. See http://docs.travis-ci.com/ for more details.
# The behavior of the script is controlled by environment variabled defined
# in the .travis.yml in the top level folder of the project.
#
# This script is inspired by Scikit-Learn (http://scikit-learn.org/)
#

set -e

pip install -U pip setuptools
pip install -r requirements.txt

if [[ "$COVERAGE" == "true" ]]; then
    pip install -r requirements-dev.txt
fi

travis-cleanup() {
    printf "Cleaning up environments ... "  # printf avoids new lines
    echo "DONE"
}
