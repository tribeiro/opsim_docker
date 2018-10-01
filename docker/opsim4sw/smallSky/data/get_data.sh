#!/bin/bash
set -e

curl -OL https://raw.githubusercontent.com/lsst/sims_skybrightness_pre/master/data/data_down.sh

chmod +x data_down.sh

./data_down.sh
