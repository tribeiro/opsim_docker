#!/bin/bash
export LSST_DDS_DOMAIN=SOCS-DOCKER-${HOSTNAME}

source scl_source enable devtoolset-6; source /home/opsim/stack/loadLSST.bash

# ts_astrosky_model
cd /home/opsim/repos/ts_astrosky_model
git checkout master
setup ts_astrosky_model git
scons

cd /home/opsim

/bin/bash --rcfile /home/opsim/.opsim4_profile_fbs
